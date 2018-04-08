//
//  LPTableFooterView.m
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPTableFooterView.h"

@implementation LPTableFooterView
+ (instancetype)getFooterView
{
    static LPTableFooterView *footerView;
    if (!footerView) {
        NSString *identifier = NSStringFromClass([LPTableFooterView class]);
        LPTableFooterView *
        footerView = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
        footerView.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return footerView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
