//修改bug的页面
#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BugStore.h"
#import "BugModel+CoreDataProperties.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"
extern  NSString *SERVER_IP ;
extern NSString *SERVER_PORT;

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mTitle;
@property (weak, nonatomic) IBOutlet UITextField *describe;
@property (weak, nonatomic) IBOutlet UITextField *solution;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation BNRDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    BNRItem *item = self.item;

    self.mTitle.text = item.title;
    self.describe.text = item.describe;
   // self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    self.solution.text=item.solution;
    // You need a NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }

    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}
- (IBAction)updateBug:(UIButton *)sender {
    [self updateBugById:self.item.bugid];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // Clear first responder
    [self.view endEditing:YES];
    

    // "Save" changes to item
    BNRItem *item = self.item;
    item.title = self.mTitle.text;
    item.describe = self.describe.text;
    //item.bugdetail = [self.valueField.text intValue];
    item.solution=self.solution.text;
    

}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = @"BugDetail";
}


//修改某个bug
//POST      http://139.199.0.47:8000/bug/modify
//可传入的参数
//{
//    "title": "title",
//    "description": "description",
//    "answer": "answer",
//    "url": "url",
//    "category": "category",
//    "errorCode": "errorCode",
//    "correctedCode": "correctedCode",
//    "picture": "picture",
//}
//另外还需要传入bid作为bug的特殊识别
-(void)updateBugById:(NSString*)bid
{
    NSString* mTitle=self.mTitle.text;
    NSString* describe=self.describe.text;
    NSString* solution=self.solution.text;
    if ([mTitle isEqualToString:@""] || [describe isEqualToString:@""] ||[solution isEqualToString:@""] ) {
        [self.view makeToast:@"请填写完整信息"];
        // Clear first responder
        [self.view endEditing:YES];
        return;
    }
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/modify",SERVER_IP,SERVER_PORT]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    
    request.HTTPBody = [[NSString stringWithFormat: @"title=%@&description=%@&answer=%@&bid=%@",mTitle,describe,solution ,bid] dataUsingEncoding:NSUTF8StringEncoding];
    //    request.HTTPBody = [@"{'title'='test3'}" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if ([dict[@"status"] isEqualToString:@"successed"]) {
            NSLog(@"修改成功");
            [self.view makeToast:@"修改成功"];
          
            // "Save" changes to item
            BNRItem *item = self.item;
            item.title = mTitle;
            item.describe = describe;
            //item.bugdetail = [self.valueField.text intValue];
            item.solution=solution;
            
            //保存到数据库
            BugStore* store=[[BugStore alloc]init];
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context =   delegate.persistentContainer.viewContext;
            BNRItem* model=[[BNRItem alloc]init];
            model.title=item.title;
            model.describe=item.describe;
            model.solution=item.solution;
            [store updateBug:model ByBugid:item.bugid withContext:context];
            
            
            //返回列表页
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:true];
            });
        }else{
            NSLog(@"修改失败");
            [self.view makeToast:@"修改失败"];
        }
        
        
    }];
    
    //7.执行任务
    [dataTask resume];
}

@end
