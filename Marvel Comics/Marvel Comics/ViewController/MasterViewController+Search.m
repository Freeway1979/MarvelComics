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
        [searchBar resignFirstResponder];
        self.searchWord = searchText;
        self.offset = 0;
        lastSearchText = searchText;
        [self buildDataSource];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarCancelButtonClicked");
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked %@",searchBar.text);
    [searchBar resignFirstResponder];
    
    //
    NSString *searchText = searchBar.text;
    if ([searchText isEqualToString:lastSearchText]) {
        return;
    }
    //rebuild data source and update views
    self.searchWord = searchText;
    self.offset = 0;
    lastSearchText = searchText;
    [self buildDataSource];
}
@end
