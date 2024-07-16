# Mutation testing practice

In this practice, we will learn how to use mutation testing on a real project to evaluate test quality.
For this purpose, we will use the [mutalk](https://github.com/pharo-contributions/mutalk) library on top of Pharo 11.

## Setup

For this practice, you will need to:
 - install the pharo launcher
 - install Pharo11 through the launcher
 - install mutalk in Pharo:
   - open a playground
   - execute the following expression:
  
```smalltalk
Deprecation activateTransformations: false.
Metacello new
  baseline: 'MuTalk';
  repository: 'github://pharo-contributions/mutalk:v2.3.0/src';
  load.
```

## Starting with code coverage

In the beginning of this practice we are going to study Pharo's UUID library.
Later, we are going to pass on to more complex libraries that also have more interesting results.

Open the DrTest tool in Pharo using the menu `Browse > DrTest`.

<img width="343" alt="imagen" src="https://github.com/UnivLille-Meta/Miage23/assets/708322/2cc39d99-59be-4dc7-afad-c7388bc690c1">

There select `Test Coverage` in the combo box. Tell the UI you want to analyse the coverage using the tests in the `Network-Tests` package and you want to evaluate how it covers the package `Network-UUID`.

<img width="799" alt="imagen" src="https://github.com/UnivLille-Meta/Miage23/assets/708322/c60409e8-d344-4ea7-a4dc-ff42ff47c26b">

Things to think about:
- How much coverage does it show?
- How can you increase the coverage?
- Is coverage a good proxy for code and test quality?

## Mutating UUID

Now let's analyse the quality of Pharo's UUID library from a mutation testing perspective:

```smalltalk
testCases :=  { UUIDPrimitivesTest }.
classesToMutate := { UUID. UUIDGenerator }.

analysis := MTAnalysis new
    testClasses: testCases;
    classesToMutate: classesToMutate.

analysis run.
```

Executing the previous code does have some interesting outcomes.
First, we can ask the result for the mutation score. In this case, we have a score of 37, meaning that 37% of the mutants were killed.

```smalltalk
analysis generalResult mutationScore
```

Also, we can retrieve the alive mutants to work on them programatically.
Doing programatic analysis being a bit more hardcore for a first approach, we will better do it through a GUI instead in next section.

```smalltalk
"To retrieve the alive mutations"
alive := analysis generalResult aliveMutants.
```

Things to think about:
- The mutation score clearly differs from the coverage percentage. Can you come up with some ideas of how to bridge this gap?
- What measure is more precise? What does it mean precise anyways when thinking about test quality?
- Are both analyses useful? Or one is better and can replace the other for all purposes?

### Understanding alive mutants

Inspecting the `generalResult` object yields a GUI showing the surviving mutants.
We can now click on them, see what is the code that was changed and do a case-by-case analysis to see what happened.

```smalltalk
analysis generalResult.
```

<img width="883" alt="imagen" src="https://github.com/avl-univ-lille/testing/assets/708322/af19408c-07cb-4412-9efa-e0d3cef5e230">

Remember, when a mutant remains alive this means that no test broke due to this change.
This could be due to many different issues. Either
 - the test suite is not strong enough: we miss some tests
 - the mutation is equivalent: the code mutated but generated code that does the same
 - or (as a special case of the previous one) the mutated code is dead code: thus it will never be executed

Things to think about:
- Before we had *not covered method* (actually the tool measures it at a finer granularity but it is not shown...), and now we have *surviving mutants*. What is the relationship between them? Why they differ in number? Are there implementation differences in the analyses? Or some important differences between the approaches?
- Related to the question before: can you think about an example of code that is covered but fails mutation testing?

### Increasing the mutation score

The best way to increase the mutation score is to write a test covering the missing case.
Fortunately, there are more tests for UUID in the `UUIDTest` class.

1. Change the list of test classes from

```smalltalk
testCases :=  { UUIDPrimitivesTest }.
```

to:

```smalltalk
testCases :=  { UUIDPrimitivesTest. UUIDTest }.
```

2. Run the analisys again. What is the different in score now?


Now that we have harvested the low-hanging fruits, we can try to write a test.
For example, we see lots of mutations survived in the following method:

```smalltalk
UUID >> fromString: aString
	"Read a UUID from aString with my official representation, 32 lowercase hexadecimal (base 16) digits, displayed in five groups separated by hyphens, in the form 8-4-4-4-12 for a total of 36 characters (32 alphanumeric characters and four hyphens)"

	| uuid |
	aString size ~= 36 ifTrue: [
		self error: 'a UUID should be 36 characters' ].
	uuid := self nilUUID.
	uuid readFrom: aString readStream.
	^ uuid
```

This means that method is probably not well covered.
If we check, that method is only called with correct arguments, 36-long strings with the expected format.

```smalltalk
UUIDTest >> testComparison
	| a b |
	a := UUID fromString: '0608b9dc-02e4-4dd0-9f8a-ea45160df641'.
	b := UUID fromString: 'e85ae7ba-3ca3-4bae-9f62-cc2ce51c525e'.
...

UUIDTest >> testUUIDVersion5

	| uuid |
	uuid := UUID fromString: 'edc460cf-4904-54cb-9add-47d7d6ac33f1'.
...

UUIDTest >> testUUIDVersion3

	| uuid |
	uuid := UUID fromString: 'a3bb189e-8bf9-3888-9912-ace4e6543002'.
...
```

3. add tests that will cover the missing branch, run the analysis again and explore the results.

4. Extend the list of test classes to also include `UUIDGeneratorTest`, run the analysis again and analyse the survivors.
   - which ones look like equivalent mutants? why?
   - can you change the method `UUIDGenerator>>#nextRandom16` to increase the killed mutant count even further?

## Improving Mutation Analysis Runtime

Naively computing the mutation score for a project means to run all tests once per mutant.
This means that the time to run the tests will increase with larger code bases (because more mutants could be computed) and with bigger test cases.

For example, our previous code takes around 20 seconds to run on an Apple Silicon M1 machine.

```smalltalk
testCases :=  { UUIDPrimitivesTest. UUIDTest. UUIDGeneratorTest }.
classesToMutate := { UUID. UUIDGenerator }.

analysis := MTAnalysis new
    testClasses: testCases;
    classesToMutate: classesToMutate.

[analysis run.] timeToRun. "0:00:00:37.057"
```

To allow better configurations, Mutalk uses a modular design where the user configures differents aspects of the analysis.
In this section we will see the overview of two techniques to improve such runtime: mutant selection and test selection.

### Changing our case study

Maybe you already noticed, but the previous mutation analysis takes long time because it introduces an infinite recursion.
Thus, there is one mutation that makes the code *very* slow and makes tests to time out.
Also, the library has high code coverage and it's very small, so there are few chances of optimisation here.

To make things more interesting, let's change our test subject to Pharo's PDF generation library.
You can install Artefact PDF through:

```smalltalk
Metacello new
	githubUser: 'pharo-contributions' project: 'Artefact' commitish: 'master' path: 'src';
	baseline: 'Artefact';
	load.
```

And run mutation analysis with the following script:

```smalltalk
testCases := {PDFHorizontalLayoutTest. PDFBasicTest. PDFElementTest. PDFLayoutTest. PDFColorTest. PDFFontTest. PDFParagraphTest. PDFDataTypeTest. PDFGeneratorTest. PDFStreamPrinterTest}.
classesToMutate := 'Artefact-Core' asPackage definedClasses.

analysis := MTAnalysis new
    testClasses: testCases;
    classesToMutate: classesToMutate.

analysis run.
```

This analysis takes around 2 minutes (it was 1 minute, 54 secs in my machine when I ran this).

### Test selection

One way to reduce the runtime of mutation testing is to run the analysis on a subset of the original tests.
This technique uses code coverage as a metric:

1. it first runs all tests and evaluates the code coverage of each test. Particularly, it remembers what method was covered by what test.
2. then, it computes mutants
3. then, we proceed to run mutations. For each mutation it:
    1. installs the mutation
    2. runs only the tests covering the mutated method
    3. uninstall the mutation

By default mutalk optimizes the execution using this technique to select tests, and stops test execution as soon as one test fails.
There are, however, options to run all tests.
The two snippets of code below allow us to run the analysis by running all tests, and by running all tests and not stopping on the first failure.

```smalltalk
analysis := MTAnalysis new
    testClasses: testCases;
    classesToMutate: classesToMutate;
    testSelectionStrategy: MTAllTestsMethodsRunningTestSelectionStrategy new.

analysis := MTAnalysis new
    testClasses: testCases;
    classesToMutate: classesToMutate;
    testSelectionStrategy: MTAllTestsMethodsRunningTestSelectionStrategy new;
    stopOnErrorOrFail: false.
```

Running these two configurations gives us an idea of the power of these optimizations.
Running all the tests but stopping on the first failure took 25 seconds more (2'19 seconds).
Running without stopping on the first failure took a total of 4 minutes.

Compared to the original 2 minutes, such optimizations yielded wins of 16% and 100% respectively.

```smalltalk
(140 "seconds" / 120 "seconds") "1.16x"
(240 "seconds" / 120 "seconds") "2x"
```

Of course, the gains could be even bigger for bigger projects.

### Mutant selection

Alternatively, we could reduce the runtime of mutation testing is to run the analysis with a subset of the original mutants.
A naïve selection would, again of course, impact the results and thus the mutation score, potentially leading to misleading results.
(Although research has somewhat established that random selection *works pretty well*).
In this section, we will see a conservative way to mutant selection: *only run mutants that are covered by at least a test*.

This technique uses code coverage as a metric:
1. it first runs all tests and evaluates the code coverage of each test. Particularly, it remembers what method was covered by what test.
2. then, it computes mutants only on those methods that are covered
3. then, we proceed to run mutations. For each mutation it:
    1. installs the mutation
    2. runs the tests
    3. uninstall the mutation


To do this using mutalk, we need to use a new argument: the  `SelectingFromCoverageMutationsGenerationStrategy` class.

```smalltalk
analysis := MutationTestingAnalysis
    testCasesFrom: testCases
    mutating: classesToMutate
    using: MutantOperator contents
    with: AllTestsMethodsRunningMutantEvaluationStrategy new
    with: SelectingFromCoverageMutationsGenerationStrategy new.

mutantSelection := [analysis run.] timeToRun. "0:00:01:15.723"
```

Running this on the same machine takes 35 seconds less than the original, which means it is 1.5x faster than the original analysis.

```smalltalk
(112 "seconds" / 75 "seconds") "1.5x"
```

Of course, again , the gains could be even bigger for bigger projects that have low coverage.

Things to think about:
- Can you think about more trade-offs between coverage and mutation score?
- We saw that we can use coverage to improve mutation performance. Can you think about other usages of coverage? and what about other ways to improve mutation testing performance?


### More exercises

Do a mutation analysis of the [AVL project](https://github.com/pharo-containers/AVL).
AVL here is not Analyse et Verification de Logiciels, the M1 lecture from Univ. Lille.
Here [AVL is a tree data structure](https://en.wikipedia.org/wiki/AVL_tree) that is self-balancing, meaning it has uniform search times.

Run mutation testing on it and think about the following questions:
- is it well tested?
- is there some trivial test missing that you could add?
- How could you check if mutalk is produding *interesting* mutations? What if it's missing something important?


### Further?

Of course different other strategies could be used to improve performance.
For example, we could have a way to run a subset of the mutants given a *budget*, we could make a random selection of mutants, we could try grouping/clustering mutants.
