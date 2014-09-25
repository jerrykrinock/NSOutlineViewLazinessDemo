#import <Cocoa/Cocoa.h>
#import "LazyDataSource.h"
#import "ActualItem.h"
#import "DemoParameters.h"
#import "AppDelegate.h"

@interface ProxyItem : NSObject

@property (retain) ProxyItem* parent ;
@property (assign) NSInteger index ;

- (ActualItem*)actualItem ;

@end


@implementation ProxyItem

- (ActualItem*)actualItem {
    ProxyItem* proxyParent = [self parent] ;
    
    ActualItem* parent = [proxyParent actualItem] ;
    NSInteger index = [self index] ;
    
    // Dramatize the delay
    usleep(CHILD_FETCH_MICROSECONDS) ;
    
    return [ActualItem actualItemWithParent:parent
                                    atIndex:index] ;
}

- (NSString*)description {
    return [NSString stringWithFormat:
            @"Proxy with index=%ld and parent=%@",
            (long)[self index],
            [self parent]] ;
}

@end


@implementation LazyDataSource


- (ActualItem*)actualItemFromProxy:(ProxyItem*)proxy {
    return [proxy actualItem] ;
}


- (void)retainProxy:(ProxyItem*)proxy {
    if (!_proxies) {
        _proxies = [[NSMutableSet alloc] init] ;
    }
    
    [_proxies addObject:proxy] ;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)proxy {
    NSInteger numberOfChildren ;
    if (!proxy) {
        numberOfChildren = 1 ;
    }
    else {
        ActualItem* item = [self actualItemFromProxy:proxy] ;
        numberOfChildren = [item numberOfChildren] ;
    }
    
    return numberOfChildren ;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)proxy {
    BOOL isItemExpandable ;
    if (!proxy) {
        isItemExpandable = YES ;
    }
    else {
        ActualItem* item = [self actualItemFromProxy:proxy] ;
        isItemExpandable = ([item numberOfChildren] > 0) ;
    }
    
    return isItemExpandable ;
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)parent {
    ProxyItem* proxy = [[ProxyItem alloc] init] ;
    [proxy setParent:parent] ;
    [proxy setIndex:index] ;
    [self retainProxy:proxy] ;
    
    [(AppDelegate*)[NSApp delegate] incrementLazyChildRequests] ;
    
    if (DO_LOG_CHILD_REQUESTS) {
        NSLog(@"Child %04ld requested",
              (long)index) ;
    }
    
    return proxy ;
}

- (id)         outlineView:(NSOutlineView *)outlineView
 objectValueForTableColumn:(NSTableColumn *)tableColumn
                    byItem:(id)proxy {
    ActualItem* item = [self actualItemFromProxy:proxy] ;
    
    [(AppDelegate*)[NSApp delegate] incrementLazyColumnRequests] ;
    
    return [item name] ;
}



@end
