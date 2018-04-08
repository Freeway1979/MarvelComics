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

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.cellArray forKey:@"cellArray"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (!self) {
        return nil;
    }
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.cellArray = [aDecoder decodeObjectForKey:@"cellArray"];
    return self;
}
@end
