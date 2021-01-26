# NUnit 3 Result Transform using Bootstrap -- Jim Scott

This folder contains a transform based on nunit3-summary/html-report.xslt

The following transform is included:

* `html-report-bootstrap.xslt` create a report with pass/fail results and output with expand/collapse


This transform may be used independently or through the `nunit3-console` `--result` option. When used with `nunit3-console`, use a command-line similar to this:

```
NOTE: When running nunit3-console in Windows Powershell or Mac you will need to surround the options with quotes

nunit-console.exe my.test.dll --result="my.test.summary.txt;transform=html-report-bootstrap.xslt"
```

```
nunit3-console.exe my.test.dll --result=my.test.summary.txt;transform=html-report-bootstrap.xslt
```

If you want to use one of the transforms separately, after the test run, you will need to use a program that can apply an XSLT transform to an XML file. Note that the input file must be in NUnit3 format.
