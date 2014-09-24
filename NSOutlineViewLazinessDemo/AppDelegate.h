#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <
NSApplicationDelegate,
NSOutlineViewDataSource> {
    IBOutlet NSTextField* childRequestsField ;
    IBOutlet NSTextField* columnRequestsField ;
}

- (IBAction)refresh:(id)sender ;
- (IBAction)reset:(id)sender ;
@end

