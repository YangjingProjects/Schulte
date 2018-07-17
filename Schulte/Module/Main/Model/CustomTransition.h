//
//  CustomTransition.h
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePresent,
    TransitionTypeDismiss
};

@interface CustomTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TransitionType type;

+ (instancetype)enlargeTransitionWithType:(TransitionType)type;

- (instancetype)initWithTransitionType:(TransitionType)type;

@end
