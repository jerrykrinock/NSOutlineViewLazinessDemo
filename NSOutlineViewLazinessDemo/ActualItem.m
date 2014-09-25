#import "ActualItem.h"
#import "DemoParameters.h"


@implementation ActualItem

+ (ActualItem*)actualItemWithParent:(ActualItem*)parent
                            atIndex:(NSInteger)index {
    ActualItem* item = [[self alloc] init] ;
    NSString* name ;
    NSInteger numberOfChildren ;
    if (!parent) {
        name = @"Mother" ;
        numberOfChildren = NUMBER_OF_ITEMS ;
    }
    else if ([[parent name] isEqualToString:@"Mother"]) {
        name = [[NSString alloc] initWithFormat:
                @"Child %04ld",
                (long)index] ;
        numberOfChildren = 0 ;
    }
    else {
        name = @"Hello Error" ;
        numberOfChildren = 0 ;
    }
    
    [item setName:name] ;
    [item setNumberOfChildren:numberOfChildren] ;
    
    return item ;
}

@end
