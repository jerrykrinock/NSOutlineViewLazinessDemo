NSOutlineViewLazinessDemo
=========================

Demonstrates how NSOutlineView is not lazy when expanding items.

Instructions:

* Build and run the project.  An outline view showing a "Mother" item will appear.
* Watch the console.
* In the outline view, click the disclosure triangle, to expand "Mother"

Result:

Several seconds of beachballing while 1000 lines print to console.  Ultimately, only about 10 items are visible in the window.
