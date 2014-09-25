#import "SSYReloadSquawkOutlineView.h"



@implementation SSYReloadSquawkOutlineView

- (void)reloadData {
    if ([[self dataSource] respondsToSelector:@selector(prepareToReload)]) {
        [(NSObject <SSYCleanOnReloadDataSource> *)[self dataSource] prepareToReload] ;
    }
    
    [super reloadData] ;

    if ([[self dataSource] respondsToSelector:@selector(recoverFromReload)]) {
        [(NSObject <SSYCleanOnReloadDataSource> *)[self dataSource] recoverFromReload] ;
    }    
}

@end
