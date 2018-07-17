//
//  ScoreEntity+CoreDataProperties.m
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//
//

#import "ScoreEntity+CoreDataProperties.h"

@implementation ScoreEntity (CoreDataProperties)

+ (NSFetchRequest<ScoreEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ScoreEntity"];
}

@dynamic user_id;
@dynamic level;
@dynamic score;
@dynamic date;

@end
