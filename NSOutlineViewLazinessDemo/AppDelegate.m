#import "AppDelegate.h"

static NSInteger countChildRequests = 0 ;
static NSInteger countColumnRequests = 0 ;

@implementation AppDelegate

#define NUMBER_OF_ITEMS 18000
#define CHILD_FETCH_MICROSECONDS 0
#define DO_LOG_CHILD_REQUESTS NO

- (IBAction)refresh:(id)sender {
    [childRequestsField setStringValue:[NSString stringWithFormat:@"%ld", (long)countChildRequests]] ;
    [columnRequestsField setStringValue:[NSString stringWithFormat:@"%ld", (long)countColumnRequests]] ;
}

- (IBAction)reset:(id)sender {
    countChildRequests = 0 ;
    countColumnRequests = 0 ;
    [self refresh:self] ;
}



- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item {
    NSInteger answer ;
    if (!item) {
        // Root
        answer = 1 ;
    }
    else if ([item integerValue] < 0) {
        // Mother
        answer = NUMBER_OF_ITEMS ;
    }
    else {
        // Child
        answer = 0  ;
    }

    return answer ;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item {
    BOOL answer ;
    if (!item) {
        // Root
        answer = YES ;
    }
    else if ([item integerValue] < 0) {
        // Mother
        answer = YES ;
    }
    else {
        // Child
        answer = NO ;
    }
    
    return answer ;
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item {
    NSInteger value ;
    if (!item) {
        // Root
        value = -1 ;
    }
    else if ([item integerValue] < 0) {
        // Mother
        value = index + 1 ;
    }
    else {
        // Child
        value = -999 ;
        NSLog(@"Internal error 205-7483 %@ %ld", item, (long)index) ;
    }
    
    id child = [[NSNumber alloc] initWithInteger:value] ;
    if (DO_LOG_CHILD_REQUESTS) {
        NSLog(@"Child %04ld requested",
              (long)index) ;
    }

    // Dramatize the delay
    usleep(CHILD_FETCH_MICROSECONDS) ;
    
    countChildRequests++ ;

    return child ;
}

- (id)         outlineView:(NSOutlineView *)outlineView
 objectValueForTableColumn:(NSTableColumn *)tableColumn
                    byItem:(id)item {
    NSString* object ;
    if (!item) {
        // Root
        object = @"Root" ;  // This is never displayed
    }
    else if ([item integerValue] < 0) {
        // Mother
        object = @"Mother" ;
    }
    else {
        // Child
        object = [[NSString alloc] initWithFormat:
                  @"Child %04ld",
                  [(NSNumber*)item integerValue]] ;
    }

    countColumnRequests++ ;
    
    /*SSYDBL*/ NSLog(@"%@ = %@", [tableColumn identifier], object) ;
    return object ;
}



@end
