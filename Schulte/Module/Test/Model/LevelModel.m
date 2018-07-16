//
//  LevelModel.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "LevelModel.h"

@implementation LevelModel

- (UIColor *)levelColor {
    if (self.level <= 4) return kRGBA(36, 139, 68, 1);
    if (self.level > 4 && self.level <= 7) return kRGBA(244, 110, 48, 1);
    return kRGBA(231, 11, 40, 1);
}

- (CGSize)levelSize {
    return CGSizeMake(self.level, self.level);
}

- (double)bestScore {
    return 0;
}

@end
