#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <
NSApplicationDelegate,
NSOutlineViewDataSource> {
    NSInteger dumbChildCount ;
    NSInteger dumbColumnCount ;
    NSInteger dumbNumberCount ;
    NSInteger dumbExpandableCount ;
    NSInteger lazyChildCount ;
    NSInteger lazyColumnCount ;
    NSInteger lazyNumberCount ;
    NSInteger lazyExpandableCount ;
    
    IBOutlet NSOutlineView* dumbOutlineView ;
    IBOutlet NSTextField* dumbChildField ;
    IBOutlet NSTextField* dumbColumnField ;
    IBOutlet NSTextField* dumbNumberField ;
    IBOutlet NSTextField* dumbExpandableField ;

    IBOutlet NSOutlineView* lazyOutlineView ;
    IBOutlet NSTextField* lazyChildField ;
    IBOutlet NSTextField* lazyColumnField ;
    IBOutlet NSTextField* lazyNumberField ;
    IBOutlet NSTextField* lazyExpandableField ;
}

- (IBAction)resetDumb:(id)sender ;
- (IBAction)reloadDumb:(id)sender ;
- (void)incrementDumbChild ;
- (void)incrementDumbColumn ;
- (void)incrementDumbNumber ;
- (void)incrementDumbExpandable ;

- (IBAction)resetLazy:(id)sender ;
- (IBAction)reloadLazy:(id)sender ;
- (void)incrementLazyChild ;
- (void)incrementLazyColumn ;
- (void)incrementLazyNumber ;
- (void)incrementLazyExpandable ;

@end

