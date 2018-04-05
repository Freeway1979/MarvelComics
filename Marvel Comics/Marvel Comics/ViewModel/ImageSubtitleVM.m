//
//  ImageSubtitleVM.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "ImageSubtitleVM.h"
#import "UIImage+Processing.h"

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
    
    cell.textLabel.text = self.title;
    cell.detailTextLabel.text = self.subtitle;

    NSString *fullUrl = self.imageUrl;
    if (!fullUrl) {
        return;
    }
    //placeholder image
    cell.imageView.image = [UIImage imageNamed:@"DefaultHeaderIcon"];
    __weak UITableViewCell *weakCell = cell;
    //imageSize may be zero??
    CGRect imageSize = weakCell.imageView.frame;
    if (imageSize.size.height==0) {
        CGFloat width = weakCell.contentView.frame.size.height;
        imageSize = CGRectMake(0, 0, width, width);
    }
    [AsyncTaskManager executeAsyncTask:^{
        //Retry when failed?
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fullUrl]];
        UIImage *image = [UIImage imageWithData:data];
        UIImage *subImage = [UIImage getSubImage:image
                                         mCGRect:imageSize
                                      centerBool:NO];
        if (subImage) {
            [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                [weakCell.imageView setImage:subImage];
                [weakCell.imageView setNeedsLayout];
            }];
        }
    }];
}
@end
