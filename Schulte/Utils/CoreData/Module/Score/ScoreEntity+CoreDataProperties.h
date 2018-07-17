//
//  ScoreEntity+CoreDataProperties.h
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//
//

#import "ScoreEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ScoreEntity (CoreDataProperties)

+ (NSFetchRequest<ScoreEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *user_id;
@property (nonatomic) int16_t level;
@property (nonatomic) double score;
@property (nonatomic) int64_t date;

@end

NS_ASSUME_NONNULL_END
