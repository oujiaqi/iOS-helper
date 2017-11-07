
#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrool;

@property (weak, nonatomic) IBOutlet UITextView *contentTextview;

@end

@implementation BNRDetailViewController

-(void)textViewDidChange:(UITextView *)textView {
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
    textView.frame= newFrame;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}
-(IBAction)buttonTouch:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.sina.com.cn"]];
}



- (float) heightForString:(UITextView *)textView andWidth:(float)width{     CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.scrool.contentSize =CGSizeMake(320,568);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    
    NSString *htmlString = [NSString stringWithFormat:@"<html><body>   <font size=\"5\" color=\"black\">%@</font>,<br/><br/>描述:%@   <br/><br/>解决方法 %@ </body></html>",item.title,item.describe,item.solution];
    
    //    NSString * htmlString = @"<html><body>0. <a href=\"http://www.baidu.com/\">http://www.baidu.com</a> <br/>  1.Some html string  \n \n \n <br/> 2.This is some text! dfsdfdsfdsfgdsfdshjkfhdsjkhfjkldas  \n \n \n 3.hfjkldhgjkldhgjkldshgjlhdhgkdsjghdjskhgjkldshgjkld  \n \n \n 4.ashgjkldhgjkldshjlgkdshlghadslkdghdalghadlsjkghlksahgkljdsahglkjadhdkjlgha";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    
  
    
    
    
   // NSString * htmlString = @"<html><body>0. <a href=\"http://www.baidu.com/\">http://www.baidu.com</a> <br/>  1.Some html string  \n \n \n <br/> 2.This is some text! dfsdfdsfdsfgdsfdshjkfhdsjkhfjkldas  \n \n \n 3.hfjkldhgjkldhgjkldshgjlhdhgkdsjghdjskhgjkldshgjkld  \n \n \n 4.ashgjkldhgjkldshjlgkdshlghadslkdghdalghadlsjkghlksahgkljdsahglkjadhdkjlgha</body></html>";
    //NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    
    self.contentTextview.attributedText = attrStr;
    
    
    //    self.nameField.text = item.bugid;
    //    self.serialNumberField.text = item.bugtype;
    //    self.textView.layer.borderColor = [[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1] CGColor];
    //    self.textView.layer.borderWidth = 0.5f;
    //    self.textView.layer.cornerRadius = 5.0f;
    //    self.textView.text=@"sadasdasssssssssssssssssssssssssssssssssssssssssssssssssssssssssss";
    //    CGFloat width = CGRectGetWidth(self.textView.frame);
    //    CGFloat height = CGRectGetHeight(self.textView.frame);
    //    CGSize newSize = [self.textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    //    CGRect newFrame = self.textView.frame;
    //    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
    //    self.textView.frame= newFrame;        // self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    //    self.valueField.text=item.bugdetail;
    //    // You need a NSDateFormatter that will turn a date into a simple date string
    //    static NSDateFormatter *dateFormatter;
    //    if (!dateFormatter) {
    //        dateFormatter = [[NSDateFormatter alloc] init];
    //        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    //        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    //    }
    //
    // Use filtered NSDate object to set dateLabel contents
    //   / self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    //    BNRItem *item = self.item;
    //    item.bugid = self.nameField.text;
    //    item.bugtype = self.serialNumberField.text;
    //    //item.bugdetail = [self.valueField.text intValue];
    //    item.bugdetail=self.valueField.text;
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = @"BugDetail";
}

@end
