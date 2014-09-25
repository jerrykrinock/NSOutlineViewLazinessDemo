#import "AppDelegate.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    /* We refresh on a schedule instead of observing changes, because changes
     come in faster than the eye can see.  Sometimes the stupid way is 
     actually the smarter way :))  */
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(refresh:)
                                   userInfo:nil
                                    repeats:YES] ;
}

- (IBAction)refresh:(id)sender {
    [dumbChildField setStringValue:[NSString stringWithFormat:@"%ld", (long)dumbChildCount]] ;
    [dumbColumnField setStringValue:[NSString stringWithFormat:@"%ld", (long)dumbColumnCount]] ;
    [dumbNumberField setStringValue:[NSString stringWithFormat:@"%ld", (long)dumbNumberCount]] ;
    [dumbExpandableField setStringValue:[NSString stringWithFormat:@"%ld", (long)dumbExpandableCount]] ;
    [lazyChildField setStringValue:[NSString stringWithFormat:@"%ld", (long)lazyChildCount]] ;
    [lazyColumnField setStringValue:[NSString stringWithFormat:@"%ld", (long)lazyColumnCount]] ;
    [lazyNumberField setStringValue:[NSString stringWithFormat:@"%ld", (long)lazyNumberCount]] ;
    [lazyExpandableField setStringValue:[NSString stringWithFormat:@"%ld", (long)lazyExpandableCount]] ;
}

- (IBAction)resetDumb:(id)sender {
    dumbChildCount = 0 ;
    dumbColumnCount = 0 ;
    dumbNumberCount = 0 ;
    dumbExpandableCount = 0 ;
}

- (IBAction)reloadDumb:(id)sender {
    [dumbOutlineView reloadData] ;
}

- (void)incrementDumbChild {
    dumbChildCount++ ;
}

- (void)incrementDumbColumn {
    dumbColumnCount++ ;
}

- (void)incrementDumbNumber {
    dumbNumberCount++ ;
}

- (void)incrementDumbExpandable {
    dumbExpandableCount++ ;
}

- (IBAction)resetLazy:(id)sender {
    lazyChildCount = 0 ;
    lazyColumnCount = 0 ;
    lazyNumberCount = 0 ;
    lazyExpandableCount = 0 ;
}

- (IBAction)reloadLazy:(id)sender {
    [lazyOutlineView reloadData] ;
}

- (void)incrementLazyChild {
    lazyChildCount++ ;
}

- (void)incrementLazyColumn {
    lazyColumnCount++ ;
}

- (void)incrementLazyNumber {
    lazyNumberCount++ ;
}

- (void)incrementLazyExpandable {
    lazyExpandableCount++ ;
}

@end
