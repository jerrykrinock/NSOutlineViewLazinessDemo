#import <Cocoa/Cocoa.h>

@class DumbDataSource ;
@class LazyDataSource ;

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
    IBOutlet DumbDataSource* dumbDataSource ;
    IBOutlet NSTextField* dumbChildField ;
    IBOutlet NSTextField* dumbColumnField ;
    IBOutlet NSTextField* dumbNumberField ;
    IBOutlet NSTextField* dumbExpandableField ;
    IBOutlet NSTextField* dumbItemCountField ;

    IBOutlet NSOutlineView* lazyOutlineView ;
    IBOutlet LazyDataSource* lazyDataSource ;
    IBOutlet NSTextField* lazyChildField ;
    IBOutlet NSTextField* lazyColumnField ;
    IBOutlet NSTextField* lazyNumberField ;
    IBOutlet NSTextField* lazyExpandableField ;
    IBOutlet NSTextField* lazyItemCountField ;
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

