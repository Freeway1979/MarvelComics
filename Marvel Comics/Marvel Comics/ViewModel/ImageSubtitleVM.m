//
//  ImageSubtitleVM.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "ImageSubtitleVM.h"

#import "UIIMageView+LPImageCache.h"

@implementation ImageSubtitleVM

- (instancetype) initWithImageUrl:(NSString *)imageUrl
                            title:(NSString *)title
                         subtitle:(NSString *)subtitle
{
    if (self=[super init]) {
        self.imageUrl = imageUrl;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}
- (void)configureCell:(UITableViewCell *)cell
{
    if (cell.textLabel) {
        cell.textLabel.text = self.title;
    }
    if (cell.detailTextLabel) {
        cell.detailTextLabel.text = self.subtitle;
    }
    NSString *fullUrl = self.imageUrl;
    if (!fullUrl) {
        return;
    }
    //placeholder image
    cell.imageView.image = [UIImage imageNamed:@"DefaultHeaderIcon"];
    //
    UIImageView *imageView = cell.imageView;
    [imageView setImageWithURL:[NSURL URLWithString:fullUrl]
              placeholderImage:[UIImage imageNamed:@"DefaultHeaderIcon"]
                       options:0];
    
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (!self) {
        return nil;
    }
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
    self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
    return self;
}
@end
