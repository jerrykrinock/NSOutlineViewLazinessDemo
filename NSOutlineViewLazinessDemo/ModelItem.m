#import "ModelItem.h"
#import "DemoParameters.h"


@implementation ModelItem

+ (ModelItem*)modelItemWithParent:(ModelItem*)parent
                            atIndex:(NSInteger)index {
    ModelItem* item = [[self alloc] init] ;
    NSString* name ;
    NSInteger numberOfChildren ;
    if (!parent) {
        name = @"Mother" ;
        numberOfChildren = NUMBER_OF_ITEMS ;
    }
    else if ([[parent name] isEqualToString:@"Mother"]) {
        name = [[NSString alloc] initWithFormat:
                @"Child %05ld",
                (long)index] ;
        numberOfChildren = 0 ;
    }
    else {
        name = @"Hello Error" ;
        numberOfChildren = 0 ;
    }
    
    [item setName:name] ;
    [item setNumberOfChildren:numberOfChildren] ;
    
    /* Dramatize the delay that it might take to retrieve, construct or
     fetch an actual model item in a real project. */
    usleep(SIMULATE_MODEL_FETCH_MICROSECONDS) ;

    return item ;
}

@end
