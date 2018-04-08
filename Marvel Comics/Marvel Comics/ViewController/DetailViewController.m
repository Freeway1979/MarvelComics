//
//  DetailViewController.m
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "DetailViewController.h"
#import "CharacterDetailDataController.h"
#import "GroupImageSubtitleVM.h"
#import "ImageSubtitleVM.h"
#import "CharacterTableViewCell.h"
#import "DetailViewController+Transition.h"

static NSString *Identifier = @"TableViewCell";
@interface DetailViewController ()

@property (strong,nonatomic) CharacterDetailDataController *dataController;

@property (strong,nonatomic) NSArray<GroupImageSubtitleVM *> *dataSource;

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    WS(ws);
    [self.dataController buildDataSource:nil
                                 success:^(id dataSource) {
                                     [ws onDataSourceChanged:dataSource];
                                 } failure:^(NSError * error) {
                                     
                                 }];
    //Load server data
    [AsyncTaskManager executeAsyncTask:^{
        [ws.dataController loadServerData];
    }];
}
- (void)onDataSourceChanged:(id)dataSource
{
    self.dataSource = dataSource;
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataController = [[CharacterDetailDataController alloc] initViewController:self character:self.character];
   
    [self setupViews];
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setupViews
{
    NSString *className = NSStringFromClass([CharacterTableViewCell class]);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    [self.tableView registerNib:[UINib nibWithNibName:className bundle:mainBundle]
         forCellReuseIdentifier:className];
    
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(CharacterVM *)newDetailItem {
    if (self.character != newDetailItem) {
        self.character = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


#pragma mark table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30.f;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 45.f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //TODO:remove hardcode
        return 94.0f;
    }
    return 45.0f;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    
    if (indexPath.section == 0) {
        NSString *identifier = NSStringFromClass([CharacterTableViewCell class]);
        CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:nil options:nil] firstObject];
        }
        CharacterVM *vm = self.character ;
        [vm configureCell:cell];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
    }
    
    ImageSubtitleVM *cellVM = [[self.dataSource objectAtIndex:indexPath.section].cellArray objectAtIndex:indexPath.row];
    
    [cellVM configureCell:cell];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    GroupImageSubtitleVM *groupVM = [self.dataSource objectAtIndex:section];
    return groupVM.cellArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return nil;
    }
    GroupImageSubtitleVM *groupVM = [self.dataSource objectAtIndex:section];
    UIView *view;
    UIView* myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    UILabel *heradlable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, screenWidth-70, 30)];
    heradlable.textColor = [UIColor grayColor];
    [heradlable setText:groupVM.title];
    [myView addSubview:heradlable];
    
    view = myView;
    return view;
}

@end
