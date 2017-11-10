
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "ServerInterface.h"
#import "BNRDetailViewController.h"
#import "AddViewController.h"
#import "BugStore.h"
#import "BugModel+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Bug.h"
#import "UIView+Toast.h"


extern  NSString *SERVER_IP ;
extern NSString *SERVER_PORT;

@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic) NSMutableArray* resultArray;

@end

@implementation BNRItemsViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; i++) {
           [[BNRItemStore sharedStore] intItems];
        }
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    //    ServerInterface* store=[[ServerInterface alloc]init];
//    [store getBugs];
    
    
    self.resultArray = [[NSMutableArray alloc]init];
    [self getAllBugsFromServer];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
   
    
    UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    leftlabel.textColor = [UIColor blackColor];
    leftlabel.userInteractionEnabled  = YES;
    leftlabel.text =@"Edit";
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(edit)];
    [leftlabel addGestureRecognizer:labelTapGestureRecognizer];
    
    
    UILabel *rightlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    rightlabel.textColor = [UIColor blackColor];
    rightlabel.userInteractionEnabled  = YES;
    rightlabel.text =@"Add";
    UITapGestureRecognizer *labelTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(add)];
    [rightlabel addGestureRecognizer:labelTapGestureRecognizer1];
    
    
    
    
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftlabel];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightlabel];
    
    self.navigationItem.rightBarButtonItem=rightitem;
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    
    
    
    //    self.navigationItem.rightBarButtonItem = ({
    //        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(add)];
    //        item;
    //    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData:) name:@"datachanged" object:nil];
    
    
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    //    UIView *header = self.headerView;
    //    [self.tableView setTableHeaderView:header];
}

    
    
    
    //UIView *header = self.headerView;
    //[self.tableView setTableHeaderView:header];

    


-(NSArray*)getAllBugsFromLocal{
    BugStore* store=[[BugStore alloc]init];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    //1. 获得context
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    NSArray *resultArray =  [store selectAllBugs:context];
    
    return resultArray;
}

-(void)getAllBugsFromServer{

    [self getBugs];
    
}

- (UIView *)headerView
{
    // If you haven't loaded the headerView yet...
    if (!_headerView) {

        // Load HeaderView.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }

    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = [[item description] sizeWithFont:font constrainedToSize:CGSizeMake(320,1000) lineBreakMode:NSLineBreakByWordWrapping];
    cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y, 320, size.height);
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = font;
    cell.textLabel.text = [item description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
   
   

    return cell;
}

- (void)add
{
    //    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    //
    //    // Figure out where that item is in the array
    //    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    //
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    //
    //    // Insert this new row into the table.
    //    [self.tableView insertRowsAtIndexPaths:@[indexPath]
    //                          withRowAnimation:UITableViewRowAnimationTop];
    AddViewController *add=[[AddViewController alloc]init];
    //    NSArray *items=[[BNRItemStore sharedStore]allItems];
    //    BNRItem *selectedItem=items[indexPath.row];
    //    add.item=selectedItem;
    [self.navigationController pushViewController:add animated:YES];
}


- (void)edit
{
    
    NSLog(@"Method in controller.");
    NSLog(@"Button clicked.");
    if (self.isEditing) {
        // Change text of button to inform user of state
        //        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change tet of button to inform user of state
        //        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
    
    
}

- (void)   tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
   forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
      
        //向服务器发送删除请求
        [self deleteBugFromServer:item indexPath:indexPath];
    }
}

- (void)   tableView:(UITableView *)tableView
  moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
         toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

- (IBAction)addNewItem:(id)sender
{
//         // Create a new BNRItem and add it to the store
//    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
//
//    // Figure out where that item is in the array
//    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//
//    // Insert this new row into the table.
//    [self.tableView insertRowsAtIndexPaths:@[indexPath]
//                          withRowAnimation:UITableViewRowAnimationTop];
    AddViewController *add=[[AddViewController alloc]init];
//    NSArray *items=[[BNRItemStore sharedStore]allItems];
//    BNRItem *selectedItem=items[indexPath.row];
//    add.item=selectedItem;
      [self.navigationController pushViewController:add animated:YES];
}

- (IBAction)toggleEditingMode:(id)sender
{
    // If you are currently in editing mode...
    if (self.isEditing) {
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];

        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change tet of button to inform user of state
       // [sender setTitle:@"Done" forState:UIControlStateNormal];

        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailviewcontroller=[[BNRDetailViewController alloc]init];
    NSArray *items=[[BNRItemStore sharedStore]allItems];
    BNRItem *selectedItem=items[indexPath.row];
    detailviewcontroller.item=selectedItem;
    [self.navigationController pushViewController:detailviewcontroller animated:YES];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}


//    获取多个bug
//    GET      http://139.199.0.47:8000/bug/get/several?start=0&count=10
//    需要传入参数 start  表示开始的位置最小值为0
//    count  表示传回的个数
//    返回的格式为多个bug的字典，以各自的序列值为键
-(void)getBugs
{
    
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/get/several",SERVER_IP,SERVER_PORT]];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil ) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if ([dict[@"status"] isEqualToString:@"failed"]) {
                NSLog(@"暂时没有内容~");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view makeToast:@"暂时没有内容~" duration:2.0
                                position:CSToastPositionCenter];
                });
                
                return ;
            }
            BNRItemStore* store=[BNRItemStore sharedStore] ;
            for (NSString *key in dict) {
                NSDictionary *value = dict[key];
                Bug *model=[[Bug alloc]init];
                model.bugid=key;
                model.category=value[@"category"];
                model.errorCode=value[@"errorCode"];
                model.correctCode=value[@"correctCode"];
                model.solution=value[@"answer"];
                model.title=value[@"title"];
                model.url=value[@"url"];
                model.describe=value[@"description"];
                
                NSString *dateString = value[@"createTime"];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *date=[formatter dateFromString:dateString];
                model.createTime=date;
                
                NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://%@:%@%@",SERVER_IP,SERVER_PORT,value[@"picture"]]];
                UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
                model.image=image;
                
                //[self.resultArray addObject:model];
                
                BNRItem* item=[[BNRItem alloc]initWithBugTitle:model.title BugDescribe:model.describe BugSolution:model.solution];
//                BNRItem* item=[[BNRItem alloc]initWithBugTitle:@"1" BugDescribe:@"2"  BugSolution:@"3"];
                item.bugid=model.bugid;
                [store addItem:item];
                
                NSLog(@"bugid=%@ title=%@ describe=%@ category=%@ errorCode=%@ correctCode=%@ createTime=%@ solution=%@ url=%@",model.bugid,model.title,model.describe,model.category,model.errorCode,
                      model.correctCode,model.createTime,model.solution,model.url);
            }
            //刷新一下页面
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [self.tableView reloadData];
//                [self.tableView setNeedsDisplay];//非[self setNeedsDisplay];
//                [self.tableView setNeedsLayout];
            });
         
    
            
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}
-(void)deleteBugFromServer:(BNRItem*)item indexPath:(NSIndexPath*)indexPath
{
    
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/del/one?bid=%@",SERVER_IP,SERVER_PORT,item.bugid]];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString* status=dict[@"status"];
            if ([status isEqualToString:@"successed"]) {
                [[BNRItemStore sharedStore] removeItem:item];
//                [self.resultArray removeObjectAtIndex:indexPath.row];
                // Also remove that row from the table view with an animation
                //刷新一下页面
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                    //warning:下面这一句如果直接写，不用dispatch_async，程序会很卡的
                    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:UITableViewRowAnimationFade];
                });
               
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view makeToast:@"删除失败" duration:2.0
                                position:CSToastPositionCenter];
                });
 
            }

        }
    }];
    
    //5.执行任务
    [dataTask resume];
}



@end
