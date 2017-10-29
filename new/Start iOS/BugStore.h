//
//  BugStore.h
//  Bug
//
//  Created by brodyli on 2017/9/16.
//  Copyright © 2017年 TouchTracker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BugModel+CoreDataClass.h"
#import "BNRItem.h"
@interface BugStore : NSObject
-(void)save:(BugModel*)bug witContext:(NSManagedObjectContext *)context;

- (int)deleteByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context;

-(void)save:(BugModel*)bugModel withContext:(NSManagedObjectContext*)context;

-(NSArray* )selectAllBugs :(NSManagedObjectContext*)context;

- (NSArray* )selectByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context;

- (NSArray* )selectByBugTitle:(NSString*)title withContext:(NSManagedObjectContext*)context;

- (int)updateBugTitle:(NSString *)title ByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context;

- (int)updateBug:(BNRItem *)bug ByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context;
@end
