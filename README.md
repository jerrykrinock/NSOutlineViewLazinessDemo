NSOutlineViewLazinessDemo
=========================

Demonstrates how NSOutlineView is not lazy when expanding items, and how to work around the issue by using a lazy data source.

Instructions:

* Build and run the project in Xcode 6.1.  An window with two outline views will appear.
* Watch the console.
* In the "Dumb" outline view, click the disclosure triangle, to expand "Mother", and note how long it takes.
* Repeat for the "Lazy" outline view.

Although the Lazy Data Source does fix the performance, it is quite a bit more complicated.  You'll' need to add the following code.  Only the first item is shown in this demo.  This is still a work in progress.

1.  Extra code in the data source (compare LazyDataSource.h/.m to DumbDataSource.h/.m), including the ProxyItem class.

2.  Note that your data source must retain proxy items for as long as the outline view might ask for them again.  I do this with a mutable set that contains all proxies, and a mutable array which contains only the root proxies (children of root).  For the latter, as well as for the children collections within each proxy object, I use the -putObject:atIndex: and -cleanObjectAtIndex: in lieu of -insertObject:atIndex: and -removeObjectAtIndex:, which maintain placeholders for missing objects and safely allow the array to be built up out of order.  These methods are defined in NSArray+SSYDisjoint.h/m, which is in my CategoriesObjC repository on github.com

3.  If your outline view is editable, your implementation of -outlineView:shouldEditTableColumn:item: will need to convert the 'item' from a proxy item to model item.

4.  If your outline view supports copying items, your implementation of -outlineView:writeItems:toPasteboard: will need to convert the 'item' from an array of proxy items to an array of model items.

5.   If your outline view supports drag and drop, the several methods you implement in the data source (outlineView:validateDrop:proposedItem:proposedChildIndex:, -outlineView:acceptDrop:item:childIndex:, etc.) you'll need to convert the 'item' from a proxy item to a model item.  If you use -setDropItem:dropChildIndex:, of course, it will need the opposite coversion

6.  Probably override your outline view's -rowForItem:, because you're probably passing model items in to this method, but'super will only find its row if you pass it the corresponding proxy item.

7.  Next in line, you'd think you need to override outline view's -itemAtRow:, but you can't do that because Cocoa invokes that method and expects to get the proxy item.  Instead, you must define some kind of -modelItemForRow: method and always use this method instead of -itemAtRow: when you want the model item represented at a given row.

The next two items are similar to keeping a "cache" (your tree of proxy items) in sync with your data model. 

8.  CHeck all proxies, correcting or removing defunct proxies, whenever an item's children, or their order, are changed, so that a subsequent -reloadData will cause the removed branches of the proxy tree to be rebuilt as -outlineView:child:ofItem is invoked.  To make sure you don't miss any such settings, it is best to catch these changes at a low level, for example, by posting notifications from custom setters of -setParent: and -setIndex: methods in your model item class, or by using KVO, or observing NSManagedObjectContextObjectsDidChangeNotification.

 You may want to use the following algorithm for making array B (your retained array or proxies) match array A (say, a fetch of all model items).  It is
efficient for array types that use my NSArray+SSYDisjoint methods to maintain placeholders.

. for each element B[i] of B
.     get the same-indexed element of A, A[i]
.     if A[i] is absent or is a null placeholder,
.        create a new element
.        replace A[i] in A with the new element
.     for each attribute of the A[i] (which may be the new element)
.         if attribute is different than the same attribute in B[i]
.         set the attribute in A[i] to equal that of B[i]
. remove all elements of B, B[i] whose index is greater than i at the end of the above iteration.


You might be tempted to just remove all proxies prior to every -reloadData operation.  While that works, and seems to be safe because NSOutlineView seems to forget all of the (proxy) items which you have previously returned in -outlineView:child:ofItem: upon receiving -reloadData, in practice that will cause annoying "flickering" because all objects will be removed and replaced if a change is made to only a single item/row, for example.  I only do this after an Undo or Redo operation, or when making a gross change such as changing the outine view into flat/table mode to show search results.

9.  Check all proxies, removing those which no longer reflect the current parent/child hierarchy, after an Undo or Redo operation.  After this, the subsequent -reloadData will cause the removed branches of the proxy tree to be rebuilt as -outlineView:child:ofItem is invoked.  This is the most practical method for handling undo/redo which I could imagine for a data model based on Core Data. This is because Core Data does not use change values with KVC compliance when it performs an Undo or Redo; therefore the custom setters or KVO suggested in the previous item do not get triggered.  I think that if your model was not based on Core Data, you migght be able to hook into whatever Undo/Redo actuators you have written.

10.  In delegate methods such as outlineView:itemDidExpand:, convert from proxy item to model item.

11.  When you invoke -expandItem: or -collapseItem:, you need to pass a proxy item.

12.  If you implement -dataCellForRow:, assuming that this computation.depends on item.

13.  Other gotchas which are specific to your application :))

Because of these complications, it would be nice if Apple would build the laziness into NSOutlineView and stop invoking -outlineView:child:ofItem: unnecessarily.  I reported this issue to Apple as Bug 18394553 on 2014-09-19.  However, since NSOutlineView has behaved this way for decades, we're much more likely to get a new AppKit before they get around to this bug.

One more thing: If you build this project in Xcode 5, the cells do not get the text taken from the data source.  Presumably this is due to the "Latest" SDK being 10.10 vs. 10.9.  It would be interesting to know why, but I've lost interest in Xcode 5.
'
