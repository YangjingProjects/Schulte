//
//  TestCell.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell


- (void)setModel:(TestModel *)model {
    
    _model = model;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.contentView.backgroundColor = kRGB(41, 41, 41);
    
    UILabel *levelLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont systemFontOfSize:[self sizeWithLevel:model.level]];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%ld", (long)model.number];
        label;
    });
    [self.contentView addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

- (void)setIsSelected:(BOOL)isSelected {
    if (!isSelected) return;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.contentView.backgroundColor = self.model.heighlightColor;
    }];

    _isSelected = isSelected;
}

- (NSInteger)sizeWithLevel:(NSInteger)level {
    if (level == 2) return 45;
    if (level == 3) return 42;
    if (level == 4) return 35;
    if (level == 5) return 32;
    if (level == 6) return 25;
    if (level == 7) return 22;
    if (level == 8) return 19;
    return 15;
}

@end
