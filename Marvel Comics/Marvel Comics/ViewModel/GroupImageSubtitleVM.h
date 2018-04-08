//
//  GroupImageSubtitleVM.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupImageSubtitleVM : NSObject <NSCoding>

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) NSArray *cellArray;

- (instancetype) initWithTitle:(NSString *) title
                     cellArray:(NSArray *) cellArray;
@end
