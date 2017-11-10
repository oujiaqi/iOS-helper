//
//  Bug.h
//  Start iOS
//
//  Created by brodyli on 2017/10/28.
//  Copyright © 2017年 stev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bug : NSObject
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
