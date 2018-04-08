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
#import "ImageCacheManager.h"

#pragma mark - DataResult
@interface DataResult ()

@end
@implementation DataResult

@end


@implementation CharacterDataController
- (instancetype)initViewController:(MasterViewController *)viewController {
    if (self=[super init]) {
        self.limit = RecordNumberPerPage;
        self.offset = 0;
        self.isPaginationMode = YES;
        self.vc=viewController;
        
        self.prefetechResultDic = [NSMutableDictionary dictionary];
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
- (void) prefetechData
{
    NSLog(@"prefetechData");
    CharacterListRequest *request = [CharacterListRequest new];
    request.nameStartsWith = self.request.nameStartsWith;
    request.limit = self.request.limit;
    request.offset = self.request.offset + RecordNumberPerPage;
    WS(ws);
    [self buildDataSource:request
                  success:^(id data) {
                      BaseResponseData *responseData = data;
                      [ws onPrefetechDataSourceChanged:responseData.results
                                               request:request];
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                  
    }];
}
- (void)onPrefetechDataSourceChanged:(NSArray<MCharacter *> *)data
                             request:(CharacterListRequest *)request
{
    //save request information
    DataResult *result = [self setRequestResult:request];
    result.prefetchedData = data;
    
    //Start to download images
    //And cached to memory and disk
    for (MCharacter *ch in data) {
        NSString *imageUrl = ch.thumbnail.fullThumbnailUrl;
        if (imageUrl.length>0) {
           ImageCacheManager *cacheManager = [ImageCacheManager shared];
            [cacheManager backgroundDownloadImageWithURL:[NSURL URLWithString:imageUrl]];
        }
    }
    
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
    CharacterListRequest *request = [self buildParameters:self.searchWord
                                                    limit:RecordNumberPerPage
                                                   offset:self.offset
                                                  orderBy:nil];
    self.request = request;
    DataResult *result = [self getRequestResult:request];
    if (result && result.prefetchedData) {
        [self onDataSourceChanged:result.prefetchedData];
        return;
    }
    [self.vc showLoadingAnimation];
    isFetechingData = YES;
    WS(ws);
    [self buildDataSource:request
                  success:^(id data) {
                                     BaseResponseData *responseData = data;
                                     [ws onDataSourceChanged:responseData.results];
                                     isFetechingData = NO;
                                     //save request information
                                     [ws setRequestResult:request];
                                     [ws.vc dismissLoadingAnimation];
                                 }
                  failure:^(NSError *error) {
                                     NSLog(@"%@",error);
                  
                                     isFetechingData = NO;

                                     [ws.vc dismissLoadingAnimation];
                                 }];
}
- (void)onDataSourceChanged:(NSArray *)data
{
    NSMutableArray<CharacterVM *> *list = [NSMutableArray array];
    if (self.isPaginationMode) {
        [list addObjectsFromArray:self.characterList];
    }
    NSUInteger rowCount = list.count-1;
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
    
    //Prefetech data
    WS(ws);
    [AsyncTaskManager executeAsyncTask:^{
        [ws prefetechData];
    } withPriority:DISPATCH_QUEUE_PRIORITY_BACKGROUND];
    
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
    NSUInteger maxCount = dataSource.count;
    if ((lastRowCount+1)<(maxCount-1)) {
        lastRowCount += 1;
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowCount inSection:0];
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
#pragma mark -data prefetech
- (DataResult *)getRequestResult:(CharacterListRequest *)request
{
    NSString *key = [NSString stringWithFormat:@"%@_%ld_%ld",request.nameStartsWith,request.offset,request.limit];
    DataResult *result = [self.prefetechResultDic objectForKey:key];
    if (result) {
//        NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
//        if ((nowInterval - result.resultTime) < 300*1000) {
//            return result;
//        }
        return result;
    }
    return nil;
}
- (DataResult *)setRequestResult:(CharacterListRequest *)request
{
    NSString *key = [NSString stringWithFormat:@"%@_%ld_%ld",request.nameStartsWith,request.offset,request.limit];
    DataResult *result = [self.prefetechResultDic objectForKey:key];
    if (!result) {
        result = [DataResult new];
        result.requestKey = key;
        result.isFinished = YES;
        result.resultTime = [[NSDate date] timeIntervalSince1970];
        [self.prefetechResultDic setObject:result forKey:key];
    }
    return result;
}


@end
