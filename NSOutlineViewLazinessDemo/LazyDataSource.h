#import <Foundation/Foundation.h>

@interface LazyDataSource : NSObject {
    NSMutableDictionary* _proxies ;
}

- (NSInteger)itemCount ;

@end
