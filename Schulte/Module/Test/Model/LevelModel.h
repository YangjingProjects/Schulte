//
//  LevelModel.h
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelModel : NSObject

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign, readonly) CGSize levelSize;

@property (nonatomic, strong, readonly) UIColor *levelColor;

@property (nonatomic, assign, readonly) double bestScore;

@end
