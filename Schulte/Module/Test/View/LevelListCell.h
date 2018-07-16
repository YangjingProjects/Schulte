//
//  LevelListCell.h
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelModel.h"

#define LevelListCellId     @"LevelListCellId"

@interface LevelListCell : UICollectionViewCell

@property (nonatomic, strong) LevelModel *model;

@end
