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

@interface MasterViewController () <UISearchBarDelegate>
@property (nonatomic,strong) CharacterDataController *dataController;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.characterList = [NSMutableArray array];
    [self setupViews];
    self.dataController = [[CharacterDataController alloc] init];
    //Default to pagination mode
    self.isPaginationMode = YES;
    self.limit = RecordNumberPerPage;
    self.offset = 0;
    [self registerNotificationObservers];
    
    //[UIActivityIndicatorView show:self.view timeout:3];
    
    [self buildDataSource];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
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
//    [self.tableView registerClass:[CharacterTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CharacterTableViewCell class])];
//
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
- (void) loadNextPageData {
    self.offset += self.limit;
    self.isPaginationMode = YES;
    [self buildDataSource];
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
    [LoadingView show:self.view];
    [self dismissKeyboard];
    isFetechingData = YES;
    CharacterListRequest *request = [self.dataController buildParameters:self.searchWord
                                                          limit:RecordNumberPerPage
                                                         offset:self.offset
                                                        orderBy:nil];
    WS(ws);
    [self.dataController buildDataSource:request
                                 success:^(id data) {
                                     BaseResponseData *responseData = data;
                                     [ws onDataSourceChanged:responseData.results];
                                     isFetechingData = NO;
                                     [LoadingView dismiss];
                                 } failure:^(NSError *error) {
                                     NSLog(@"%@",error);
                                     isFetechingData = NO;
                                     [LoadingView dismiss];
                                 }];
}
- (void)onDataSourceChanged:(NSArray *)dataSource
{
    NSMutableArray<CharacterVM *> *list = [NSMutableArray array];
    if (self.isPaginationMode) {
        [list addObjectsFromArray:self.characterList];
    }
    for (MCharacter *ch in dataSource) {
        CharacterVM *vm = [[CharacterVM alloc] initWithCharacter:ch];
        [list addObject:vm];
    }
    
    //Locked to avoid reading characterList to update tableView while writing.
    @synchronized(self)
    {
        self.characterList = list;
        [self.tableView reloadData];
    }
    [self dismissKeyboard];
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
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchBar:searchBar textDidChange:searchText];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchBarCancelButtonClicked:searchBar];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchBarSearchButtonClicked:searchBar];
}
@end
