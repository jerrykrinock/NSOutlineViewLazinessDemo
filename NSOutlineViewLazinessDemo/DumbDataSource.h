#import <Foundation/Foundation.h>

@interface DumbDataSource : NSObject {
    NSMutableArray* _modelItems ;
    NSInteger _deadItemCount ;
}

- (NSInteger)itemCount ;

@end
