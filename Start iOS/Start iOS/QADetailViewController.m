//
//  QADetailViewController.m
//  Start iOS
//
//  Created by PeterLocas on 2017/11/6.
//  Copyright © 2017年 stev. All rights reserved.
//

#import "QADetailViewController.h"
@interface QADetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *question;
@property (weak, nonatomic) IBOutlet UITextView *answer;


@end


@implementation QADetailViewController

-(void)viewDidLoad{
    self.navigationItem.title = @"详情";
    
    self.question.text=self.mQuestion;
}

@end
