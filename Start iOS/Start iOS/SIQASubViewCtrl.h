//
//  SIQASubViewCtrl.h
//  Start iOS
//
//  Created by stev on 2017/9/17.
//  Copyright © 2017年 stev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIQASubViewCtrl : UITableViewController

//@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property NSUInteger pageIndex;
@property NSString* titleText;

@end
