//
//  AppDelegate.h
//  Start iOS
//
//  Created by stev on 2017/9/17.
//  Copyright © 2017年 stev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@end

