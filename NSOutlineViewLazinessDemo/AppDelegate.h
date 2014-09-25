#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <
NSApplicationDelegate,
NSOutlineViewDataSource> {
    NSInteger countLazyChildRequests ;
    NSInteger countLazyColumnRequests ;

    IBOutlet NSTextField* childRequestsField ;
    IBOutlet NSTextField* columnRequestsField ;    
}

- (IBAction)refresh:(id)sender ;
- (IBAction)reset:(id)sender ;

- (void)incrementLazyChildRequests ;
- (void)incrementLazyColumnRequests ;

@end

