#import <Foundation/Foundation.h>

@interface ModelItem : NSObject

@property (retain) NSString* name ;
@property (assign) NSInteger numberOfChildren ;

+ (ModelItem*)modelItemWithParent:(ModelItem*)parent
                            atIndex:(NSInteger)index ;


@end
