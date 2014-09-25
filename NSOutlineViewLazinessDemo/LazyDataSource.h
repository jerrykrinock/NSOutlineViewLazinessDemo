#import <Foundation/Foundation.h>
#import "SSYReloadSquawkOutlineView.h"

@interface LazyDataSource : NSObject <SSYCleanOnReloadDataSource> {
    NSMutableArray* _proxies ;
    NSInteger _deadItemCount ;
}

- (NSInteger)itemCount ;

@end
