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

2.  Some mechanism to prune out proxies when the represented model items are deleted.  In an early version of this demo, I was removing all proxies whenever the supported outline view executed a -reloadData.  You don't want to do that because it causes the entire outline view contents to be redrawn whenever an item is deleted.

3.  If your outline view is editable, your implementation of -outlineView:shouldEditTableColumn:item: will need to convert the 'item' from a proxy item to model item.

4.  If your outline view supports copying items, your implementation of -outlineView:writeItems:toPasteboard: will need to convert the 'item' from an array of proxy items to an array of model items.

5.   If your outline view supports drag and drop, the several methods you implement in the data source (outlineView:validateDrop:proposedItem:proposedChildIndex:, -outlineView:acceptDrop:item:childIndex:, etc.) you'll need to convert the 'item' from a proxy item to a model item.  If you use -setDropItem:dropChildIndex:, of course, it will need the opposite coversion

6.  Probably override your outline view's -rowForItem:, because you're probably passing model items in to this method, but'super will only find its row if you pass it the corresponding proxy item.

7.  Next in line, you'd think you need to override outline view's -itemAtRow:, but you can't do that because Cocoa invokes that method and expects to get the proxy item.  Instead, you must define some kind of -modelItemForRow: method and always use this method instead of -itemAtRow: when you want the model item represented at a given row.

The next two items are similar to keeping a "cache" (your tree of proxy items) in sync with your data model. 

8.  Remove proxies whenever an item's children, or their order, are changed, so that a subsequent -reloadData will cause the removed branches of the proxy tree to be rebuilt as -outlineView:child:ofItem is invoked.  To make sure you don't miss any such settings, it is best to catch these changes at a low level, for example, by posting notifications from custom setters of -setParent: and -setIndex: methods in your model item class, or by using KVO.

9.  Check all proxies, removing those which no longer reflect the current parent/child hierarchy, after an Undo or Redo operation.  After this, the subsequent -reloadData will cause the removed branches of the proxy tree to be rebuilt as -outlineView:child:ofItem is invoked.  This is the most practical method for handling undo/redo which I could imagine for a data model based on Core Data. This is because Core Data does not use change values with KVC compliance when it performs an Undo or Redo; therefore the custom setters or KVO suggested in the previous item do not get triggered.  I think that if your model was not based on Core Data, you migght be able to hook into whatever Undo/Redo actuators you have written.

10.  In delegate methods such as outlineView:itemDidExpand:, convert from proxy item to model item.

11.  When you invoke expandItem:, you need to pass a proxy item.

12.  If you implement -dataCellForRow:, assuming that this computation.depends on item.

Because of these complications, it would be nice if Apple would build the laziness into NSOutlineView and stop invoking -outlineView:child:ofItem: unnecessarily.  I reported this issue to Apple as Bug 18394553 on 2014-09-19.  However, since NSOutlineView has behaved this way for decades, we're much more likely to get a new AppKit before they get around to this bug.

One more thing: If you build this project in Xcode 5, the cells do not get the text taken from the data source.  Presumably this is due to the "Latest" SDK being 10.10 vs. 10.9.  It would be interesting to know why, but I've lost interest in Xcode 5.
'
