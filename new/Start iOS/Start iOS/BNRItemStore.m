
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore;

    // Do I need to create a sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }

    return sharedStore;
}

// If a programmer calls [[BNRItemStore alloc] init], let him
// know the error of his ways
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

// Here is the real (secret) initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

//- (BNRItem *)createItem
//{
//    BNRItem *item = [BNRItem randomItem];
//
//    [self.privateItems addObject:item];
//
//    return item;
//}


- (BNRItem *)intItems
{
    BNRItem *item = [BNRItem getItems];

    [self.privateItems addObject:item];

    return item;
}

-(void)addItem:(BNRItem *)item{
    [self.privateItems addObject:item];
}

- (BNRItem *)createItem
{
    BNRItem *item = [[BNRItem alloc]init];
    item.bugid=[NSString stringWithFormat:@"%d",rand()];
    item.title=@"title";
    item.describe=@"describe";
    item.solution=@"solution";
    NSDate *now=[[NSDate alloc]init];
    NSTimeZone *zone=[NSTimeZone systemTimeZone];
    NSInteger inter=[zone secondsFromGMTForDate:now];
    item.dateCreated=[now dateByAddingTimeInterval:inter];  
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so you can re-insert it
    BNRItem *item = self.privateItems[fromIndex];

    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];

    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
