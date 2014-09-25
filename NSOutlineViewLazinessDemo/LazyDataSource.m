#import <Cocoa/Cocoa.h>
#import "LazyDataSource.h"
#import "ModelItem.h"
#import "DemoParameters.h"
#import "AppDelegate.h"

@interface ProxyItem : NSObject

@property (retain) ProxyItem* parent ;
@property (assign) NSInteger index ;

- (ModelItem*)modelItem ;

@end


@implementation ProxyItem

- (ModelItem*)modelItem {
    ProxyItem* proxyParent = [self parent] ;
    
    ModelItem* parent = [proxyParent modelItem] ;
    NSInteger index = [self index] ;
        
    return [ModelItem modelItemWithParent:parent
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


- (ModelItem*)modelItemFromProxy:(ProxyItem*)proxy {
    return [proxy modelItem] ;
}


- (void)retainProxy:(ProxyItem*)proxy {
    if (!_proxies) {
        _proxies = [[NSMutableSet alloc] init] ;
    }
    
    [_proxies addObject:proxy] ;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)proxy {
    [(AppDelegate*)[NSApp delegate] incrementLazyNumber] ;
    
    NSInteger numberOfChildren ;
    if (!proxy) {
        numberOfChildren = 1 ;
    }
    else {
        ModelItem* item = [self modelItemFromProxy:proxy] ;
        numberOfChildren = [item numberOfChildren] ;
    }
    
    return numberOfChildren ;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)proxy {
    [(AppDelegate*)[NSApp delegate] incrementLazyExpandable] ;
    
    BOOL isItemExpandable ;
    if (!proxy) {
        isItemExpandable = YES ;
    }
    else {
        ModelItem* item = [self modelItemFromProxy:proxy] ;
        isItemExpandable = ([item numberOfChildren] > 0) ;
    }
    
    return isItemExpandable ;
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)parent {
    [(AppDelegate*)[NSApp delegate] incrementLazyChild] ;
    
    ProxyItem* proxy = [[ProxyItem alloc] init] ;
    [proxy setParent:parent] ;
    [proxy setIndex:index] ;
    [self retainProxy:proxy] ;
    
    return proxy ;
}

- (id)         outlineView:(NSOutlineView *)outlineView
 objectValueForTableColumn:(NSTableColumn *)tableColumn
                    byItem:(id)proxy {
    [(AppDelegate*)[NSApp delegate] incrementLazyColumn] ;

    ModelItem* item = [self modelItemFromProxy:proxy] ;
    return [item name] ;
}



@end
