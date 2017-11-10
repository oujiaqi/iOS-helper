//
//  SIQAViewCtrl.h
//  Start iOS
//
//  Created by stev on 2017/9/17.
//  Copyright © 2017年 stev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIQASubViewCtrl.h"

@interface SIQAViewCtrl : UIViewController<UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;

@end
