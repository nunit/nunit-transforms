### nunit3-xunit -- Paul Hicks

Converts NUnit3 results to JUnit-style results. It deliberately drops some information: my intention is to produce a file suitable for publishing to Jenkins via the JUnit publisher.

The NUnit publisher ("NUnit plugin" for Jenkins) requires NUnit2-style results and isn't keeping up with the snazziness of the JUnit plugin. In particular, the JUnit plugin allows for claiming of individual test failures.

XML files produced by transforming NUnit3 results with the attached XLST file are suitable for publishing via the JUnit plugin.

