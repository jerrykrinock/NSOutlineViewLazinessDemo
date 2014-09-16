#import "AppDelegate.h"


@implementation AppDelegate

#define NUMBER_OF_ITEMS 1000

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
    /*SSYDBL*/ NSLog(@"Child %04ld requested",
                     (long)index) ;

    // Dramatize the delay
    usleep(3000) ;

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

    return object ;
}


@end
