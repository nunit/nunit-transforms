# NUnit Transforms

This project is a collection of contributed XSLT transforms for use with the NUnit result file.

Each transform is found in a separate folder, which contains the transform plus other files
provided by the author, normally a README and LICENSE. The NUnit team does not maintain these
contributions. Please read the README for each one and contact the author about any problems or
other assistance needed with the particular transform.

## Included Contributions

| Folder         | Purpose                                         | Author     |
|----------------|-------------------------------------------------|------------|
| [nunit3-junit](https://github.com/nunit/nunit-transforms/tree/master/nunit3-junit) | Converts NUnit3 results to JUnit-style results. | Paul Hicks |
| [nunit3-summary](https://github.com/nunit/nunit-transforms/tree/master/nunit3-summary) | Converts NUnit3 results to reports similar to those produced by the console runner. | Charlie Poole |
| [nunit2-summary](https://github.com/nunit/nunit-transforms/tree/master/nunit2-summary) | Converts NUnit2 results to reports similar to those produced by the console runner. | Charlie Poole |
<br>

## How to Use the Transforms

The transforms may be applied to the NUnit `TestResult.xml` output either through the NUnit 3
console runner or independently after a test run has completed.
<br><br>

### _Using With NUnit3 Console_

Transforms that work against the nunit3 result format are found in subfolders named like "nunit3-XXXX".

You may apply these transforms using the `nunit3-console` `--result` option. Use a command-line similar to this:

```
nunit3-console.exe my.test.dll --result=my.test.summary.txt;transform=text-summary.xslt
```

If you use one of the HTML transforms, you will want to change the file type of the result output.

Note that the `--result` option may be repeated to create several reports. If you use the above command-line,
the default `TestResult.xml` will not be saved. If you want it to be saved as well, use a command like this:

```
nunit3-console.exe my.test.dll --result=my.test.summary.txt;transform=text-summary.xslt --result=TestResult.xml
```

### _Applying the Transform Independently_

If you want to use one of the transforms separately, after the test run, you will need to use a program that
can apply an XSLT transform to an XML file. As always, the input file must be in the correct format (nunit2
or nunit3) for the particular transform you are using.

Since the V2 console runner doesn't support use of transforms, this is the only way to transform V2 output.
