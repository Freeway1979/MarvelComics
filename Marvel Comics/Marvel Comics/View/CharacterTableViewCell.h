//
//  CharacterTableViewCell.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CharacterTableViewCellDelegate <NSObject>

- (void)onFavouriteButtonClicked:(UIButton *_Nonnull)sender;

@end

@interface CharacterTableViewCell : UITableViewCell

- (IBAction)onFavouriteButtonClicked:(UIButton *_Nullable)sender;
@property (weak, nonatomic) IBOutlet UIButton * _Nullable mFavouriteButton;
@property (weak, nonatomic) IBOutlet UILabel * _Nullable mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * _Nullable mSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView * _Nullable mImageView;

@property (nonatomic, weak, nullable) id <CharacterTableViewCellDelegate> delegate;

@end
