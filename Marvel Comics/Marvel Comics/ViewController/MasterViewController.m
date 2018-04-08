//
//  MasterViewController.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CharacterDataController.h"
#import "UIActivityIndicatorView+Loading.h"
#import "NotificationName.h"
#import "MasterViewController+Search.h"
#import "MasterViewController+Transition.h"

@interface MasterViewController ()
@end

@implementation MasterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    [self setupViews];
    
    self.dataController = [[CharacterDataController alloc] initViewController:self];

    [self registerNotificationObservers];
    
    [self.dataController buildDataSource];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    //Push animation
    self.navigationController.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) registerNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onNotificationFavouriteArrived:)
                                                 name:(NSString*)NotificationFavourite object:nil];
    
}
- (void) onNotificationFavouriteArrived:(id)object
{
    //CharacterVM *vm = object;
    //reload tableview
    [self.tableView reloadData];
}
#pragma mark - Segues

- (void) gotoDetailViewController
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CharacterVM *object = [self.characterList objectAtIndex:indexPath.row];
    //DetailViewController *controller =
    //(DetailViewController *)[ topViewController];
    NSString *identifier = NSStringFromClass([DetailViewController class]);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController * controller = [sb instantiateViewControllerWithIdentifier:identifier];
    [controller setDetailItem:object];
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CharacterVM *object = [self.characterList objectAtIndex:indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - init Views
- (void) setupViews
{
    //Search Bar
    self.searchBar.delegate = self;
    
    //Table View
    NSString *className = NSStringFromClass([CharacterTableViewCell class]);
    NSBundle *mainBundle = [NSBundle mainBundle];
    [self.tableView registerNib:[UINib nibWithNibName:className bundle:mainBundle]
         forCellReuseIdentifier:className];
    
    self.tableView.tableFooterView = [UIView new];    

}

- (void)dismissKeyboard
{
    [self.searchBar becomeFirstResponder];
    [self.searchBar resignFirstResponder];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
#pragma mark - Data Controller
- (void)onDataSourceChanged:(NSArray<CharacterVM *> *)dataSource
         insertedIndexPaths:(NSArray<NSIndexPath *> *)insertedIndexPaths
          scrollToIndexPath:(NSIndexPath *)scrollToIndexPath
              isPageEnabled:(BOOL)isPageEnabled
{
    @synchronized(self)
    {
        self.characterList = dataSource;
        if (isPageEnabled) {
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:insertedIndexPaths
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            [self.tableView scrollToRowAtIndexPath:scrollToIndexPath
                                  atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else
        {
            [self.tableView reloadData];
        }
    }
    [self dismissKeyboard];
}

- (void) loadNextPageData {
    [self.dataController loadNextPage];
}

- (void)updateDataParameters:(NSString *)searchWord
                       limit:(NSUInteger)limit
                      offset:(NSUInteger)offset
               isPageEnabled:(BOOL) isPageEnabled
{
    self.dataController.searchWord = searchWord;
    self.dataController.limit = limit==0?RecordNumberPerPage:limit;
    self.dataController.offset = offset;
    self.dataController.isPaginationMode = isPageEnabled;
}
#pragma mark - loading view
- (void)showLoadingAnimation
{
    [UIActivityIndicatorView show:self.view];
}
- (void)dismissLoadingAnimation
{
    [UIActivityIndicatorView dismiss];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.characterList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell;
    //= [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *identifier = NSStringFromClass([CharacterTableViewCell class]);
    CharacterTableViewCell *theCell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (theCell == nil) {
        theCell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil] firstObject];
        theCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CharacterVM *vm = [self.characterList objectAtIndex:indexPath.row];
    [vm configureCell:theCell];
    vm.favouriteEnabled = NO;
    
    return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self gotoDetailViewController];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

#pragma mark -- UISearchBarDelegate
//MasterViewController+Search.m

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= MAX(0, scrollView.contentSize.height - scrollView.frame.size.height) + 30)
    {
        NSLog(@"Release to load");
    } else {
        //NSLog(@"Pull to load");
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y >= MAX(0, scrollView.contentSize.height - scrollView.frame.size.height) + 30)
    {
        //
        NSLog(@"loading data");
        [self loadNextPageData];
    }
}
@end
