//
//  TestCell.h
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

#define TestCellID  @"TestCellID"

@interface TestCell : UICollectionViewCell

@property (nonatomic, strong) TestModel *model;

@property (nonatomic, assign) BOOL isSelected;

@end
