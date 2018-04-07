//
//  CharacterVM.h
//  Marvel Comics
//
//  Created by Liu PingAn on 04/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCharacter.h"
#import "CharacterTableViewCell.h"

@class MCharacter;
@interface CharacterVM : NSObject <CharacterTableViewCellDelegate>

@property (nonatomic,strong) MCharacter *character;

@property (nonatomic,assign) BOOL favouriteEnabled;

@property (nonatomic,assign) BOOL favourited;

@property (nonatomic,weak) CharacterTableViewCell *cell;

- (instancetype) initWithCharacter:(MCharacter *)character;

- (void)configureCell:(CharacterTableViewCell *)cell;

@end
