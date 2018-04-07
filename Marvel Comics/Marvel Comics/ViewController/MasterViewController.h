//
//  MasterViewController.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCharacter.h"
#import "CharacterVM.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSArray<CharacterVM *> *characterList;

#pragma mark - search
@property (nonatomic,assign) NSUInteger offset;
@property (nonatomic,assign) NSUInteger limit;
@property (nonatomic,copy) NSString *searchWord;
#pragma mark -pagination
@property (nonatomic,assign) BOOL isPaginationMode;

- (void) buildDataSource;
- (void) loadNextPageData;

@end

