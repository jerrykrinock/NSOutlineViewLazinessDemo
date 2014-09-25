#import <Foundation/Foundation.h>

@interface ActualItem : NSObject

@property (retain) NSString* name ;
@property (assign) NSInteger numberOfChildren ;

+ (ActualItem*)actualItemWithParent:(ActualItem*)parent
                            atIndex:(NSInteger)index ;


@end
