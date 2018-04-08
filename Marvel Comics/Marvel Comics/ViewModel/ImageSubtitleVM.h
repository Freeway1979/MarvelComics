//
//  ImageSubtitleVM.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSubtitleVM : NSObject <NSCoding>

@property (nonatomic,copy) NSString *imageUrl;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *subtitle;

- (instancetype) initWithImageUrl:(NSString *)imageUrl
                            title:(NSString *)title
                         subtitle:(NSString *)subtitle;

- (void)configureCell:(UITableViewCell *)cell;

@end
