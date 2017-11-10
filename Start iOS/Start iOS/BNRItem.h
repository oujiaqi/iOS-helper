
#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

//+ (instancetype)randomItem;

//- (instancetype)initWithItemName:(NSString *)name
            //      valueInDollars:(int)value
             //       serialNumber:(NSString *)sNumber;
 
//@property (nonatomic, copy) NSString *itemName;
//@property (nonatomic, copy) NSString *serialNumber;
//@property (nonatomic) int valueInDollars;
//@property (nonatomic, readonly, strong) NSDate *dateCreated;

+(instancetype)getItems;
- (instancetype)initWithBugTitle:(NSString *)title
                        BugDescribe:(NSString *)describe
                      BugSolution:(NSString *)solution;
@property (nonatomic, copy) NSString *bugid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic,copy)  NSString *solution;
@property (nonatomic, strong) NSDate *dateCreated;
@end
