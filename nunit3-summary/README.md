# NUnit 3 Summary Transforms -- Charlie Poole

This folder contains a set of transforms extracted from the nunit-summary program (http://github.com/charliepoole/nunit-summary) and renamed for easier use. They essentially duplicate the output that is produced by the NUnit 3 Console runner when the test is run, extracting the necessary information from the nunit3-formatted XML result file.

The following transforms are included:

* `html-report.xslt` creates a report similar to what the console itself displays in html format.
* `html-summary.xslt` creates the summary report alone in html format.
* `text-report.xslt` creates a report similar to what the console itself displays in text format.
* `text-summary.xslt` creates the summary report alone in text format.'
