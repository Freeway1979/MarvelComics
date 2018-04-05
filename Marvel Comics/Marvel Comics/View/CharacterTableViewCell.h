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

- (IBAction)onFavouriteButtonClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *mFavouriteButton;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@property (nonatomic, weak, nullable) id <CharacterTableViewCellDelegate> delegate;

@end
