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

// This method is for the demo only.  You won't need it in typical usage.
-(void)countNodesInObject:(id)object
                  count_p:(NSInteger*)count_p
                   parent:(id)parent {
    
    if([object isKindOfClass:[NSDictionary class]]){
        
        for(NSString * key in [object allKeys]){
            id child = [object objectForKey:key];
            [self countNodesInObject:child
                             count_p:count_p
                              parent:object] ;
        }
        
        
    }
    else {
        (*count_p)++ ;
    }
}


// This method is for the demo only.  You won't need it in typical usage.
- (NSInteger)itemCount {
    NSInteger count = 0 ;
    [self countNodesInObject:_proxies
                     count_p:&count
                      parent:nil] ;
    return count ;
}

- (void)prepareToReload {
}

- (ModelItem*)modelItemFromProxy:(ProxyItem*)proxy {
    return [proxy modelItem] ;
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
    
    NSValue* parentValue = [NSValue valueWithPointer:(__bridge const void *)(parent)] ;
    NSNumber* indexValue = [NSNumber numberWithInteger:index] ;
    ProxyItem* proxy = [[_proxies objectForKey:parentValue] objectForKey:indexValue] ;

    if (!proxy) {
        proxy = [[ProxyItem alloc] init] ;
        
        [proxy setParent:parent] ;
        [proxy setIndex:index] ;
        
        if (!_proxies) {
            _proxies = [[NSMutableDictionary alloc] init] ;
        }
        
        NSMutableDictionary* parentDic = [_proxies objectForKey:parentValue] ;
        if (!parentDic) {
            parentDic = [[NSMutableDictionary alloc] init] ;
            [_proxies setObject:parentDic
                                forKey:parentValue] ;
        }
        [parentDic setObject:proxy
                      forKey:indexValue] ;
    }
    
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
