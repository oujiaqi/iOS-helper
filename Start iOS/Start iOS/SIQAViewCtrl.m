//
//  SIQAViewCtrl.m
//  Start iOS
//
//  Created by stev on 2017/9/17.
//  Copyright © 2017年 stev. All rights reserved.
//

#import "SIQAViewCtrl.h"

@interface SIQAViewCtrl ()

@end

@implementation SIQAViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageTitles = @[@"OC", @"Swift", @"iOS", @"Other"];
    
    //create the page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QAPageViewCtrl"];
    self.pageViewController.dataSource = self;
    
    SIQASubViewCtrl *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    //change the size of the page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-30);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (SIQASubViewCtrl *)viewControllerAtIndex:(NSUInteger) index{
    if (([self.pageTitles count] ==0 )|| (index >= [self.pageTitles count])) {
        return  nil;
    }
    
    SIQASubViewCtrl *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QASubView"];
    //pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((SIQASubViewCtrl*) viewController).pageIndex;
    
    if ((index == 0)||(index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((SIQASubViewCtrl*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageTitles count]) {
        return  nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end
