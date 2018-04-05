//
//  DetailViewController.h
//  Marvel Comics
//
//  Created by Liu PingAn on 03/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCharacter.h"
#import "CharacterVM.h"

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) CharacterVM *character;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)setDetailItem:(CharacterVM *)newDetailItem ;

@end

