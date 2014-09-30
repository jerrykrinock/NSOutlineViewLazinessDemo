NSOutlineViewLazinessDemo
=========================

Demonstrates how NSOutlineView is not lazy when expanding items, and how to work around the issue by using a lazy data source.

Instructions:

* Build and run the project in Xcode 6.1.  An window with two outline views will appear.
* Watch the console.
* In the "Dumb" outline view, click the disclosure triangle, to expand "Mother", and note how long it takes.
* Repeat for the "Lazy" outline view.

Although the Lazy Data Source does fix the performance, it is quite a bit more complicated.  Besides the extra code that you see in LazyDataSource.m and the addition of SSYReloadSquawkOutlineView.m (or whatever mechanism you choose to use to get reload notifications), you're also going to have to convert from proxy item to model item wherever you read items out of the outline view for any purpose, for example, to display in a detail view.  So it would be nice if Apple would build the laziness into NSOutlineView and stop invoking -outlineView:child:ofItem: unnecessarily.  I reported this issue to Apple as Bug 18394553 on 2014-09-19.  However, since NSOutlineView has behaved this way for decades, I think we're likely to get a new AppKit before they get around to this bug.'

Note: If you build in Xcode 5, the cells do not get the text taken from the data source.  Presumably this is due to the "Latest" SDK being 10.10 vs. 10.9.  If anyone can explain this, please comment – I'd like to know why.
