#import <Cocoa/Cocoa.h>
#import "DumbDataSource.h"
#import "AppDelegate.h"
#import "ModelItem.h"

@implementation DumbDataSource

- (NSInteger)itemCount {
    return [_modelItems count] ;
}

- (void)retainModelItem:(ModelItem*)modelItem {
    if (!_modelItems) {
        _modelItems = [[NSMutableArray alloc] init] ;
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

#pragma mark * SSYCleanOnReloadDataSource Protocol Support

- (void)prepareToReload {
    _deadItemCount = [self itemCount] ;
}

- (void)recoverFromReload {
    NSRange deadRange = NSMakeRange(0, _deadItemCount) ;
    NSIndexSet* deadIndexSet = [NSIndexSet indexSetWithIndexesInRange:deadRange] ;
    [_modelItems removeObjectsAtIndexes:deadIndexSet] ;
}

@end
