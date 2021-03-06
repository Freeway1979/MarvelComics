//
//  MasterViewController.h
//  Marvel Comics  -- List of characters page by page
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCharacter.h"
#import "CharacterVM.h"
#import "CharacterDataController.h"
 
@class DetailViewController;
@class CharacterDataController;

@interface MasterViewController : UITableViewController<UISearchBarDelegate,UIScrollViewDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic,strong) CharacterDataController *dataController;

@property (strong, nonatomic) NSMutableArray<CharacterVM *> *characterList;

#pragma mark - loading view
- (void)showLoadingAnimation;

- (void)dismissLoadingAnimation;

- (void)onDataSourceChanged:(NSArray<CharacterVM *> *)dataSource
              isPageEnabled:(BOOL)isPageEnabled;

- (void)updateDataParameters:(NSString *)searchWord
                       limit:(NSUInteger)limit
                      offset:(NSUInteger)offset
               isPageEnabled:(BOOL) isPageEnabled;

- (void) loadNextPageData;

@end

