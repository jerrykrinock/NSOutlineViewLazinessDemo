#import "AppDelegate.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(refresh:)
                                   userInfo:nil
                                    repeats:YES] ;
}

- (IBAction)refresh:(id)sender {
    [childRequestsField setStringValue:[NSString stringWithFormat:@"%ld", (long)countLazyChildRequests]] ;
    [columnRequestsField setStringValue:[NSString stringWithFormat:@"%ld", (long)countLazyColumnRequests]] ;
}

- (IBAction)reset:(id)sender {
    countLazyChildRequests = 0 ;
    countLazyColumnRequests = 0 ;
    [self refresh:self] ;
}

- (void)incrementLazyChildRequests {
    countLazyChildRequests++ ;
}

- (void)incrementLazyColumnRequests {
    countLazyColumnRequests++ ;
}

@end
