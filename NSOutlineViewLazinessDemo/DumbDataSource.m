#import <Cocoa/Cocoa.h>
#import "DumbDataSource.h"
#import "AppDelegate.h"
#import "ModelItem.h"

@implementation DumbDataSource

- (void)retainModelItem:(ModelItem*)modelItem {
    if (!_modelItems) {
        _modelItems = [[NSMutableSet alloc] init] ;
    }
    
    [_modelItems addObject:modelItem] ;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(ModelItem*)item {
    [(AppDelegate*)[NSApp delegate] incrementDumbNumber] ;
    
    NSInteger numberOfChildren ;
    if (!item) {
        numberOfChildren = 1 ;
    }
    else {
        numberOfChildren = [item numberOfChildren] ;
    }
    
    return numberOfChildren ;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(ModelItem*)item {
    [(AppDelegate*)[NSApp delegate] incrementDumbExpandable] ;
    
    BOOL isItemExpandable ;
    if (!item) {
        isItemExpandable = YES ;
    }
    else {
        isItemExpandable = ([item numberOfChildren] > 0) ;
    }
    
    return isItemExpandable ;
}

- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)parent {
    [(AppDelegate*)[NSApp delegate] incrementDumbChild] ;
    
    ModelItem* modelItem = [ModelItem modelItemWithParent:parent
                                                  atIndex:index] ;
    [self retainModelItem:modelItem] ;
    
    return modelItem ;
}

- (id)         outlineView:(NSOutlineView *)outlineView
 objectValueForTableColumn:(NSTableColumn *)tableColumn
                    byItem:(ModelItem*)item {
    [(AppDelegate*)[NSApp delegate] incrementDumbColumn] ;
    
    return [item name] ;
}

@end
