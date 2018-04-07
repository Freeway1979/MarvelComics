//
//  CharacterDataController.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterDataController.h"
#import "MarvelNetProvider.h"
#import "NSString+Format.h"
#import "LoadingView.h"

@implementation CharacterDataController
- (instancetype)initViewController:(MasterViewController *)viewController {
    if (self=[super init]) {
        self.limit = RecordNumberPerPage;
        self.offset = 0;
        self.isPaginationMode = YES;
        self.vc=viewController;
    }
    return self;
}
- (void)loadNextPage
{
    self.offset += self.limit;
    self.isPaginationMode = YES;
    [self buildDataSource];
}
- (CharacterListRequest *)buildParameters:(NSString *)searchName
                            limit:(NSUInteger)limit
                           offset:(NSUInteger)offset
                          orderBy:(NSString *)orderBy
{
    CharacterListRequest *request = [CharacterListRequest new];
    request.nameStartsWith = searchName;
    request.limit = limit;
    request.offset = offset;
    request.orderBy = orderBy;
    return request;
}
- (void) buildDataSource
{
    //Avoid of mutilple requests in short time.
    static BOOL isFetechingData;
    @synchronized(self)
    {
        if (isFetechingData) {
            return;
        }
    }
    //[LoadingView show:self.vc.view];
    [self.vc showLoadingAnimation];
    isFetechingData = YES;
    CharacterListRequest *request = [self buildParameters:self.searchWord
                                                    limit:RecordNumberPerPage
                                                   offset:self.offset
                                                  orderBy:nil];
    WS(ws);
    [self buildDataSource:request
                                 success:^(id data) {
                                     BaseResponseData *responseData = data;
                                     [ws onDataSourceChanged:responseData.results];
                                     isFetechingData = NO;
                                     //[LoadingView dismiss];
                                     [ws.vc dismissLoadingAnimation];
                                 } failure:^(NSError *error) {
                                     NSLog(@"%@",error);
                                     isFetechingData = NO;
                                     //[LoadingView dismiss];
                                     [ws.vc dismissLoadingAnimation];
                                 }];
}
- (void)onDataSourceChanged:(NSArray *)data
{
    NSMutableArray<CharacterVM *> *list = [NSMutableArray array];
    if (self.isPaginationMode) {
        [list addObjectsFromArray:self.characterList];
    }
    NSUInteger rowCount = list.count;
    NSMutableArray<CharacterVM *> *newData = [NSMutableArray arrayWithCapacity:[data count]];
    for (MCharacter *ch in data) {
        CharacterVM *vm = [[CharacterVM alloc] initWithCharacter:ch];
        [newData addObject:vm];
    }
    [list addObjectsFromArray:newData];
    
    //Locked to avoid reading characterList to update tableView while writing.
    if (self.isPaginationMode) {
        [self insertRowsOfData:newData
                    dataSource:list
                  lastRowCount:rowCount];
    }
    else
    {
        self.characterList = list;
        [self.vc onDataSourceChanged:list
                  insertedIndexPaths:nil
                   scrollToIndexPath:nil
                       isPageEnabled:NO];
        
    }
}

- (void)insertRowsOfData:(NSArray<CharacterVM *> *)data
              dataSource:(NSArray<CharacterVM *> *)dataSource
            lastRowCount:(NSUInteger)lastRowCount
{
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:[data count]];
    for (int index = 0; index < [data count]; index++) {
        CharacterVM *item = [data objectAtIndex:index];
        NSUInteger row = [dataSource indexOfObject:item];
        NSIndexPath *newPath =  [NSIndexPath indexPathForRow:row inSection:0];
        NSLog(@"%@ %ld %ld",newPath,newPath.section,newPath.row);
        [insertIndexPaths addObject:newPath];
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowCount+1 inSection:0];
    self.characterList = dataSource;
    [self.vc onDataSourceChanged:dataSource
              insertedIndexPaths:insertIndexPaths
               scrollToIndexPath:lastIndexPath
                   isPageEnabled:YES];
}


/**
 Load Data Source from anywhere (network,local database,and file cache,etc...)

 @param request <#params description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
- (void)buildDataSource:(CharacterListRequest *)request
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure {
    
    [MarvelNetProvider getCharacterList:request
                                success:^(BaseResponse *response) {
        if (success && response) {
            [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                success(response.data);
            }];
        }
    } failure:^(NSError *error) {
        if (failure) {
            [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                failure(error);
            }];
        }
    }];
    
}

@end
