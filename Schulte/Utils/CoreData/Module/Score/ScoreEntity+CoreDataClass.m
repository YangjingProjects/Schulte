//
//  ScoreEntity+CoreDataClass.m
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//
//

#import "ScoreEntity+CoreDataClass.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation ScoreEntity

+ (void)insertScoreWithLevel:(NSInteger)level score:(double)score userId:(NSString *)userId complete:(CompleteBlock)complete {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"level = '%ld' and user_id = 'test'", (long)level]];
        ScoreEntity *entity = [ScoreEntity MR_findFirstWithPredicate:predicate inContext:localContext];
        if (!entity) entity = [ScoreEntity MR_createEntityInContext:localContext];
        entity.user_id = @"test";
        entity.level = level;
        entity.score = score;
        entity.date = [[NSDate date] timeIntervalSince1970];
        
    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (complete) complete(contextDidSave, error);
    }];
}

+ (ScoreEntity *)selecteScoreWithLevel:(NSInteger)level userId:(NSString *)userId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"level = '%ld' and user_id = 'test'", (long)level]];
    ScoreEntity *entity = [ScoreEntity MR_findFirstWithPredicate:predicate];
    return entity;
}

@end
