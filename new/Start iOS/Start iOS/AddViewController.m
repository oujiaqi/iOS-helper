//
//  AddViewController.m
//  test1007
//
//  Created by James on 17/10/8.
//  Copyright © 2017年 com.tencent. All rights reserved.

//添加bug的页面
//

#import "AddViewController.h"
#import "BNRItem.h"
#import "BugStore.h"
#import "AppDelegate.h"
#import "BNRItemStore.h"
#import "UIView+Toast.h"
extern  NSString *SERVER_IP ;
extern NSString *SERVER_PORT;
@interface AddViewController ()



@property (weak, nonatomic) IBOutlet UITextField *mTitle;
@property (weak, nonatomic) IBOutlet UITextField *describe;
@property (weak, nonatomic) IBOutlet UITextField *solution;


@end

@implementation AddViewController


//添加页面-点击back按钮时触发
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
 
    
}
- (IBAction)btnAdd:(UIButton *)sender {
    // "Save" 
    [self addBugToServer];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    //self.navigationItem.title = _item.bugid;
    self.navigationItem.title=@"CreatBug";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addBugToServer
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/add",SERVER_IP,SERVER_PORT]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    
    request.HTTPBody = [[NSString stringWithFormat: @"title=%@&description=%@&answer=%@",mTitle,describe,solution ] dataUsingEncoding:NSUTF8StringEncoding];
    //    request.HTTPBody = [@"{'title'='test3'}" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if([dict[@"status"] isEqualToString:@"successed"] ){
            if ([dict[@"bugid"] isEqualToString:@""]) {
                NSLog(@"bugid为空");
                return ;
            }
            NSLog(@"添加成功");
            [self.view makeToast:@"添加成功" duration:2.0
                        position:CSToastPositionCenter];
            
            // "Save"
            BNRItem *item = [[BNRItem alloc] init];
            item.title= self.mTitle.text;
            item.describe= self.describe.text;
            item.solution = self.solution.text;
            item.bugid=dict[@"bid"];
            BNRItemStore* itemStore=[BNRItemStore sharedStore] ;
            [itemStore addItem:item];
            
            //保存到coredata中
            BugStore* store=[[BugStore alloc]init];
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context =   delegate.persistentContainer.viewContext;
            BugModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"BugModel" inManagedObjectContext:context];//不能用[[BugModel alloc]init],否则报错
            model.bugid=item.bugid;
            model.title=item.title;
            model.describe=item.describe;
            //        model.category=item.category;
            //        model.errorCode=@"errcode2";
            //        model.correctCode=@"correctcode3";
            model.createTime=item.dateCreated;
            model.solution=item.solution;
            //        model.url=@"http://p0.ifengimg.com/pmop/2017/0915/601C4EB90E86FC287B791045A20A00952C7F5A49_size35_w640_h480.jpeg";
            //        model.image=[UIImage imageNamed:@"pic.jepg"];// TODO:展示图片
            [store save:model withContext:context];
            //返回列表页
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:true];
            });
            
        }else{
            NSLog(@"添加失败");
        }
        
      
        
    }];
    
    //7.执行任务
    [dataTask resume];
}



@end
