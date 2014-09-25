#import <Cocoa/Cocoa.h>

@protocol SSYCleanOnReloadDataSource

/*!
 @brief    Message sent to the data source, if it responds. of an
 SSYReloadSquawkOutlineView, just prior to reloading its data.
 */
 - (void)prepareToReload ;

/*!
 @brief    Message sent to the data source, if it responds. of an
 SSYReloadSquawkOutlineView, just after it has reloaded its data.
 */
- (void)recoverFromReload ;

@end

/*!
 @brief    An outline view which sends the messages declared in
 SSYCleanOnReloadDataSource to its data source, if it responds, the first one
 just prior to reloading data and the second one just after.
 
 @details  Typically, the data source uses the first message to note those
 items which it is currently retaining because they have been given to the
 outline view, and the second message to release those items, because after an
 outline view has reloaded its data, it will not make any further reference to
 items which it had displayed before the reload.  The whole purpose, in this
 case, is to reduce peak memory usage.
 */
@interface SSYReloadSquawkOutlineView : NSOutlineView

@end
