//
//  BugModel+CoreDataProperties.m
//  Bug
//
//  Created by brodyli on 2017/9/16.
//  Copyright © 2017年 TouchTracker. All rights reserved.
//

#import "BugModel+CoreDataProperties.h"

@implementation BugModel (CoreDataProperties)

+ (NSFetchRequest<BugModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BugModel"];
}

@dynamic bugid;
@dynamic category;
@dynamic correctCode;
@dynamic createTime;
@dynamic describe;
@dynamic errorCode;
@dynamic image;
@dynamic solution;
@dynamic title;
@dynamic url;

@end
