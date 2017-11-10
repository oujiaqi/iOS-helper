//
//  BugStore.m
//  Bug
//
//  Created by brodyli on 2017/9/16.
//  Copyright © 2017年 TouchTracker. All rights reserved.
//

#import "BugStore.h"
#import "BNRItem.h"
#import <UIKit/UIKit.h>
@implementation BugStore

-(void)save:(BugModel*)bug witContext:(NSManagedObjectContext *)context{
    
   
    // 通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if (context.hasChanges) {
        [context save:&error];
    }
    // 错误处理
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
    }

}



- (int)deleteByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context
{
    //删除 先找到，然后删除
    NSEntityDescription *bug = [NSEntityDescription entityForName:@"BugModel" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:bug];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bugid=%@",bugid];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    //执行查询
    //    NSManagedObject *obj = [[context executeFetchRequest:request error:nil] lastObject];
    NSArray* objs=[context executeFetchRequest:request error:nil];
    int deleteCount=0;
    //删除
    if (objs.count>0) {
        for (NSManagedObject* obj in objs) {
            [context deleteObject:obj];
            [context save:nil];
            deleteCount=deleteCount+1;
        }
    }
    
    return deleteCount;
    
    
}


-(void)save:(BugModel*)bugModel withContext:(NSManagedObjectContext*)context{
    //4. 调用context,保存实体,如果没有成功，返回错误信息
    NSError *error;
    if ([context save:&error]) {
        NSLog(@"save ok");
    }
    else
    {
        NSLog(@"%@",error);
    }
    
}

-(NSArray* )selectAllBugs :(NSManagedObjectContext*)context{
    
    
    NSEntityDescription *bug = [NSEntityDescription entityForName:@"BugModel" inManagedObjectContext:context];
    
    //构造查询对象
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:bug];
    
    //执行查询，返回结果集
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    
    //    //遍历结果集
    //    for (BugModel *entity in resultAry) {
    //        NSLog(@"bugid=%@ title=%@ describe=%@ category=%@ errorCode=%@ correctCode=%@ createTime=%@ solution=%@ url=%@",entity.bugid,entity.title,entity.describe,entity.category,entity.errorCode,
    //              entity.correctCode,entity.createTime,entity.solution,entity.url);
    //    }
    
    return resultArray;
}

- (NSArray* )selectByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context
{
    //    更新 (从数据库找到-->更新)
    
    NSEntityDescription *bug = [NSEntityDescription entityForName:@"BugModel" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:bug];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bugid=%@",bugid];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    
    //执行查询
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    return resultArray;
}

- (NSArray* )selectByBugTitle:(NSString*)title withContext:(NSManagedObjectContext*)context
{
    //    更新 (从数据库找到-->更新)
    
    NSEntityDescription *bug = [NSEntityDescription entityForName:@"BugModel" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:bug];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title=%@",title];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    
    //执行查询
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    return resultArray;
}

- (int)updateBugTitle:(NSString *)title ByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context
{
    //    更新 (从数据库找到-->更新)
    
    NSEntityDescription *bug = [NSEntityDescription entityForName:@"BugModel" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:bug];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bugid=%@",bugid];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    
    //执行查询
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    int modifyCount=0;//修改的记录数
    if (resultArray.count>0) {
        for (BugModel *entity in resultArray) {
            entity.title=title;
            modifyCount=modifyCount+1;
        }
    }
    [context save:nil];
    return modifyCount;
}


- (int)updateBug:(BNRItem *)newBug ByBugid:(NSString*)bugid withContext:(NSManagedObjectContext*)context
{
    //    更新 (从数据库找到-->更新)
    
    NSEntityDescription *bug = [NSEntityDescription entityForName:@"BugModel" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:bug];
    
    //构造查询条件，相当于where子句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bugid=%@",bugid];
    
    //把查询条件放进去
    [request setPredicate:predicate];
    
    //执行查询
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    int modifyCount=0;//修改的记录数
    if (resultArray.count>0) {
        for (BugModel *entity in resultArray) {
            entity.title=newBug.title;
            entity.describe=newBug.describe;
            entity.solution=newBug.solution;
//            entity.category=newBug.category;
//            entity.correctCode=newBug.correctCode;
//            entity.errorCode=newBug.errorCode;
//            entity.url=newBug.url;
//            entity.image
            modifyCount=modifyCount+1;
        }
    }
    [context save:nil];
    return modifyCount;
}

@end



