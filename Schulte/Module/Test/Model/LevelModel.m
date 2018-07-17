//
//  LevelModel.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "LevelModel.h"
#import "ScoreEntity+CoreDataClass.h"

@implementation LevelModel {
    double _score;
}

- (UIColor *)levelColor {
    if (self.level <= 5) return kRGBA(36, 139, 68, 1);
    if (self.level > 5 && self.level <= 7) return kRGBA(244, 110, 48, 1);
    return kRGBA(231, 11, 40, 1);
}

- (CGSize)levelSize {
    return CGSizeMake(self.level, self.level);
}

- (double)bestScore {
    ScoreEntity *entity = [ScoreEntity selecteScoreWithLevel:self.level userId:@""];
    if (entity) {
        _score = entity.score;
    }
    return _score;
}

@end
