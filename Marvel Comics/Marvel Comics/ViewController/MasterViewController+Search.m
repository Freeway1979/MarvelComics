//
//  MasterViewController+Search.m
//  Marvel Comics
//
//  Created by Liu PingAn on 06/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MasterViewController+Search.h"

@implementation MasterViewController (Search)
static NSString *lastSearchText;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
    //User clear text to get all charaters
    if (searchText.length==0 && lastSearchText.length>0) {
        [self updateDataParameters:searchText
                             limit:0
                            offset:0
                      isPageEnabled:NO];

        lastSearchText = searchText;
        [self.dataController buildDataSource];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked %@",searchBar.text);
    //
    NSString *searchText = searchBar.text;
    if ([searchText isEqualToString:lastSearchText]) {
        return;
    }
    //rebuild data source and update views
    [self updateDataParameters:searchText
                         limit:0
                        offset:0
                 isPageEnabled:NO];
    
    lastSearchText = searchText;
    [self.dataController buildDataSource];
}
@end
