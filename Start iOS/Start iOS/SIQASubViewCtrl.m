//
//  SIQASubViewCtrl.m
//  Start iOS
//
//  Created by stev on 2017/9/17.
//  Copyright © 2017年 stev. All rights reserved.
//

#import "SIQASubViewCtrl.h"
#import "QADetailViewController.h"

@interface SIQASubViewCtrl ()

@end

@implementation SIQASubViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
 
    
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];    // Do any additional setup after loading the view.
    
    //self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLable.text = self.titleText;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or   cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    
    //    UIFont *font = [UIFont systemFontOfSize:15];
    //    CGSize size = [[item description] sizeWithFont:font constrainedToSize:CGSizeMake(320,1000) lineBreakMode:NSLineBreakByWordWrapping];
    //    cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, cell.textLabel.frame.origin.y, 320, size.height);
    //    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    cell.textLabel.numberOfLines = 0;
    
    if(indexPath.row == 0){
        if(_titleText==@"OC")
            cell.textLabel.text=@"OC问题一";
        else if(_titleText==@"Swift")
            cell.textLabel.text=@"Swift问题一";
        else if(_titleText==@"iOS")
            cell.textLabel.text=@"iOS问题一";
        else if(_titleText==@"Other")
            cell.textLabel.text=@"Other问题一";
    }else if(indexPath.row == 1){
        if(_titleText==@"OC")
            cell.textLabel.text=@"OC问题二";
        else if(_titleText==@"Swift")
            cell.textLabel.text=@"Swift问题二";
        else if(_titleText==@"iOS")
            cell.textLabel.text=@"iOS问题二";
        else if(_titleText==@"Other")
            cell.textLabel.text=@"Other问题二";
    }else if(indexPath.row == 2){
        if(_titleText==@"Swift")
            cell.textLabel.text=@"Swift问题三";
        else if(_titleText==@"iOS")
            cell.textLabel.text=@"iOS问题三";
        else if(_titleText==@"Other")
            cell.textLabel.text=@"Other问题三";
    }
    
    //cell.textLabel.text = _titleText;
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QADetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"QADetailViewController"];
    //    QADetailViewController *detail=[[QADetailViewController alloc]init];
    detail.mQuestion=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self.navigationController pushViewController:detail animated:YES];
    
    

    
}
@end




//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 //   if (self) {
        // Custom initialization
  //  }
 //   return self;
//}

//@end
