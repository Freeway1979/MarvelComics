//
//  CharacterDataController.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataControllerProtocol.h"
#import "MasterViewController.h"
#import "CharacterListRequest.h"

@interface DataResult:NSObject

@property (nonatomic,copy) NSString *requestKey;

@property (nonatomic,assign) BOOL isFinished;

@property (nonatomic,assign) NSTimeInterval resultTime;

@property (nonatomic,strong) NSArray<MCharacter *> *prefetchedData;

@end


@class MasterViewController;
@interface CharacterDataController : NSObject<DataControllerProtocol>
@property (nonatomic,weak) MasterViewController *vc;
@property (strong, nonatomic) NSArray<CharacterVM *> *characterList;

#pragma mark - search
@property (nonatomic,assign) NSUInteger offset;
@property (nonatomic,assign) NSUInteger limit;
@property (nonatomic,copy) NSString *searchWord;
#pragma mark -pagination
@property (nonatomic,assign) BOOL isPaginationMode;

@property (nonatomic,strong) CharacterListRequest *request;

- (instancetype)initViewController:(MasterViewController *)viewController;

- (void) buildDataSource;
- (void)loadNextPage;


- (CharacterListRequest *)buildParameters:(NSString *)searchName
                            limit:(NSUInteger)limit
                           offset:(NSUInteger)offset
                          orderBy:(NSString *)orderBy;

#pragma mark -prefetech data
@property (nonatomic,strong) NSMutableDictionary<NSString *,DataResult *> *prefetechResultDic;


@end
