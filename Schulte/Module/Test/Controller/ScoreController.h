//
//  ScoreController.h
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelModel.h"

@interface ScoreController : UIViewController

@property (nonatomic, strong) LevelModel *model;

@property (nonatomic, assign) double score;

@end
