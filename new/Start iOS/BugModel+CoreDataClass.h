//
//  BugModel+CoreDataClass.h
//  Bug
//
//  Created by brodyli on 2017/9/16.
//  Copyright © 2017年 TouchTracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSObject;

NS_ASSUME_NONNULL_BEGIN

@interface BugModel : NSManagedObject
//-(instancetype)initWithBugid:(NSString*)bugid andTitle:(NSString*)title andDescription:(NSString*)describe
//                 andSolution:(NSString*)solution andCorrectCode:(NSString*)correctcode andErrorCode:(NSString*)errorcode andCreateTime:(NSDate*)createTime;
@end

NS_ASSUME_NONNULL_END

#import "BugModel+CoreDataProperties.h"
