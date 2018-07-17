//
//  ScoreEntity+CoreDataClass.h
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreEntity : NSManagedObject

typedef  void (^CompleteBlock)(BOOL contextDidSave, NSError *error);

+ (void)insertScoreWithLevel:(NSInteger)level score:(double)score userId:(NSString *)userId complete:(CompleteBlock)complete;

+ (ScoreEntity *)selecteScoreWithLevel:(NSInteger)level userId:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END

#import "ScoreEntity+CoreDataProperties.h"
