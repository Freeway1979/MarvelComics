//
//  CharacterVM.m
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "CharacterVM.h"
#import <UIKit/UIKit.h>
#import "UIImage+Processing.h"
#import "FavouriteDataProvider.h"

#import "NotificationName.h"

@implementation CharacterVM

- (instancetype) initWithCharacter:(MCharacter *)character
{
    self = [super init];
    if (self) {
        self.character = character;
        self.favouriteEnabled = YES;
    }
    return self;
}

- (void)configureCell:(CharacterTableViewCell *)cell {
    self.cell = cell;
    cell.delegate = self;
    MCharacter *model = self.character;
    cell.mTitleLabel.text = model.name;
    cell.mSubtitleLabel.text = model.desc;
    
    NSString *charId = [NSString stringWithFormat:@"%ld",(long)model.mid];
    self.favourited = [FavouriteDataProvider isFavouritedCharacterWithId:charId];
    
    NSString *imageName = self.favourited?@"FavouritedStar":@"UnfavouritedStar";
    [cell.mFavouriteButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //FIXME:SHOULD BE ON WORKER THREAD
    NSString *fullUrl = model.thumbnail.fullThumbnailUrl;
    if (fullUrl) {
        cell.mImageView.image = [UIImage imageNamed:@"DefaultHeadIcon"];
    }
    else {
        return;
    }
    __weak CharacterTableViewCell *weakCell = cell;
    CGRect imageSize = weakCell.mImageView.frame;
    [AsyncTaskManager executeAsyncTask:^{
        //Retry when failed?
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fullUrl]];
        UIImage *image = [UIImage imageWithData:data];
        UIImage *subImage = [UIImage getSubImage:image
                                         mCGRect:imageSize
                                      centerBool:NO];
        if (subImage) {
            [AsyncTaskManager executeAsyncTaskOnMainThread:^{
                [weakCell.mImageView setImage:subImage];
            }];
        }
    }];
}

- (void) setFavourited:(BOOL)favourited
{
    _favourited = favourited;
    
    //
    UIButton *button = self.cell.mFavouriteButton;
    NSString *imageName = self.favourited?@"FavouritedStar":@"UnfavouritedStar";
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    NSString *charId = [NSString stringWithFormat:@"%ld",self.character.mid];
    if (self.favourited) {
        [FavouriteDataProvider favouriteCharacterWithId:charId];
    }
    else
    {
        [FavouriteDataProvider unfavouriteCharacterWithId:charId];
    }
}

- (void)onFavouriteButtonClicked:(UIButton * _Nonnull)sender {
    if (self.favouriteEnabled) {
        self.favourited = !self.favourited;
        
        //POST Notification
        //OR KVO?
        CharacterVM *object = self;
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)NotificationFavourite object:object];
    }
}

@end
