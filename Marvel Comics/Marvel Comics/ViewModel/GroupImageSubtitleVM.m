//
//  GroupImageSubtitleVM.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "GroupImageSubtitleVM.h"

@implementation GroupImageSubtitleVM

- (instancetype) initWithTitle:(NSString *) title
                     cellArray:(NSArray *) cellArray
{
    if (self=[super init]) {
        self.title = title;
        self.cellArray = cellArray;
    }
    return self;
}
@end
