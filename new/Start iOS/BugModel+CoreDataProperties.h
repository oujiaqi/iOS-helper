//
//  BugModel+CoreDataProperties.h
//  Bug
//
//  Created by brodyli on 2017/9/16.
//  Copyright © 2017年 TouchTracker. All rights reserved.
//

#import "BugModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BugModel (CoreDataProperties)

+ (NSFetchRequest<BugModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString* bugid;
@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSString *correctCode;
@property (nullable, nonatomic, copy) NSDate *createTime;
@property (nullable, nonatomic, copy) NSString *describe;
@property (nullable, nonatomic, copy) NSString *errorCode;
@property (nullable, nonatomic, retain) NSObject *image;
@property (nullable, nonatomic, copy) NSString *solution;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
