//
//  DeleteCell.m
//  TableViewDelete
//
//  Created by fengpan on 2018/11/14.
//  Copyright © 2018 fengpan. All rights reserved.
//

#import "DeleteCell.h"

@implementation DeleteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addShadowToView:self.bgView withColor:[UIColor cyanColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.8;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
    
}

@end
