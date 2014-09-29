NSOutlineViewLazinessDemo
=========================

Demonstrates how NSOutlineView is not lazy when expanding items, and how to work around the issue by using a lazy data source.

Instructions:

* Build and run the project in Xcode 6.1.  An window with two outline views will appear.
* Watch the console.
* In the "Dumb" outline view, click the disclosure triangle, to expand "Mother", and note how long it takes.
* Repeat for the "Lazy" outline view.

Note: If you build in Xcode 5, the cells do not get the text taken from the data source.  Presumably this is due to the "Latest" SDK being 10.10 vs. 10.9.  If anyone can explain this, please comment – I'd like to know why.
