NSOutlineViewLazinessDemo
=========================

Demonstrates how NSOutlineView is not lazy when expanding items, and how to work around the issue by using a lazy data source.

Instructions:

* Build and run the project in Xcode 6.1.  An window with two outline views will appear.
* Watch the console.
* In the "Dumb" outline view, click the disclosure triangle, to expand "Mother", and note how long it takes.
* Repeat for the "Lazy" outline view.

Although the Lazy Data Source does fix the performance, it is quite a bit more complicated.  You need:

1.  Extra code in the data source (compare LazyDataSource.h/.m to DumbDataSource.h/.m), including the ProxyItem class.  In practice, your ProxyItem might also need to outline view as an instance variable.

The remaining items are not shown in this demo:

2.  Some mechanism to prune out proxies when the represented model items are deleted.  In an early version of this demo, I was removing all proxies whenever the supported outline view executed a -reloadData.  You don't want to do that because it causes the entire outline view contents to be redrawn whenever an item is deleted.

3.  Wherever you read items out of the outline view for any purpose, for example, to display in a detail view, or in -outlineView:shouldEditTableColumn:item:, you'll need to convert it from a proxy item to model item.

4.  Probably override your outline view's -rowForItem:, because you're probably passing model items in to this method, but'super will only find its row if you pass it the corresponding proxy item.  I've done this by iterating through the proxies and finding the one with the given model item.  One hopes you don't need to do this very often.

5.  In delegate methods such as outlineView:itemDidExpand:

6.  When you invoke expandItem:

7.  In -dataCellForRow:, assuming that this computation.depends on item.

Items 3 and 4 are not shown in this demo.

Because of these complications, it would be nice if Apple would build the laziness into NSOutlineView and stop invoking -outlineView:child:ofItem: unnecessarily.  I reported this issue to Apple as Bug 18394553 on 2014-09-19.  However, since NSOutlineView has behaved this way for decades, we're much more likely to get a new AppKit before they get around to this bug.

One more thing: If you build this project in Xcode 5, the cells do not get the text taken from the data source.  Presumably this is due to the "Latest" SDK being 10.10 vs. 10.9.  If anyone can explain this, please comment – it would be interesting to know why.
