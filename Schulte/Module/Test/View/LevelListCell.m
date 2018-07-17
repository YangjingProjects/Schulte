//
//  LevelListCell.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "LevelListCell.h"

@implementation LevelListCell

- (void)setModel:(LevelModel *)model {
    
    _model = model;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.contentView.backgroundColor = model.levelColor;
    
    UILabel *levelLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont fontWithName:@"Georgia-Bold" size:32];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%ld x %ld", (long)model.level, (long)model.level];
        label;
    });
    [self.contentView addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    UILabel *scoreLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont fontWithName:@"Georgia-Bold" size:15];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"记录: %.2f", model.bestScore];
        label;
    });
    [self.contentView addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(levelLabel.mas_bottom).offset(10);
    }];
    
}

@end
