## TP: Analyse et Vérification de Logiciels

AVL will evaluate you in a practical project concerning testing and chess games.

### Context: A chess game

The project will involve an existing chess game implementation you will have to improve and test.
The implementation in question is found in the following repository.
Please, do not hesitate to fork this repository and work on your own fork

https://github.com/UnivLille-Meta/Chess/

You will notice that this game:
 - has many features: a user interface, parsers, game rules, random playing
 - has few tests
 - it does not have the best quality and practices we learn

The idea behind these decisions is to have a small project that is still close to reality.
Reality is messy and not perfect.
The question is: can we deal with such imperfections and complexity?

### Goals

The goal of the project is to apply your learnings in automated testing.
The project will have the following three tasks:

#### Task 1: manual testing and refactoring

Choose one of the katas of the Chess readme file related to refactorings.
Imagine you have to apply that refactoring yourself.
Write manual tests that ensure that you will not break anything while doing that refactoring.

##### Task 1 Deliverables
 - A git repository with a tag named `task1`, fork of the chess repository, and containing all your improvements
 - A report of your work in a markdown file (`Task1.md`) in the root of that repository. The report should explain
     -  what are the functionalities to test for the refactoring
     -  what tests did you write and why
     -  what test you did *not* write and why

##### Task 1 Grading
Task 1 will be evaluated by the quality and thoroughness of your tests.
We will evaluate code coverage, tests for positive cases, negative cases, border cases and default values.
This accounts for 70% of the grade.

**Bonus 30% of the grade:** In addition of writing your tests, apply the kata refactoring. This shows that your tests do actually work.

**Things that count negatively:** Broken tests. Repeated code. Code that does not work.

#### Task 2: mutation testing

Run mutation testing on your project, identify missing tests and write them.

##### Task 2 Deliverables
 - A git repository with a tag named `task2`, fork of the chess repository, and containing all your improvements
 - A report of your work in a markdown file (`Task2.md`) in the root of that repository. The report should explain
     -  the scripts and configuration you used to run the analysis
     -  your initial mutation score
     -  your mutation score after adding tests
     -  what test you did *not* write and why
     -  an in-detail explanation of 3 mutants you killed and how you killed them
     -  an in-detail explanation of 3 equivalent mutants, explaining why they are equivalent

##### Task 2 Grading
Task 2 will be evaluated by the quality and thoroughness of your tests and your report explanations.
We will evaluate mutation score before and after, your understanding of killing mutant and equivalent mutants.
This accounts for 70% of the grade.

**Bonus 30% of the grade:** Analyse equivalent mutants and implement at least one strategy to minimize them. Your implementation and scripts to use it should be available in the repository. Explain your analysis and implementation in the report.

**Things that count negatively:** Broken tests. Repeated code. Code that does not work.

#### Task 3: fuzzing, oracles and property based testing

Create a grammar fuzzer for the FEN chess standard and fuzz the parser in the project.
Use mutation fuzzing on top of it to find bugs and write tests showing them.
The oracle question arrives: how do you know if the parser is ok given a random input?

Some ideas:
 - Pharo can call external processes using the [OSSubprocess library](https://github.com/pharo-contributions/OSSubprocess/)
 - Pharo can do http calls using the [Zinc http client](http://books.pharo.org/booklet-Zinc/pdf/2020-03-23-Zinc.pdf) already available in Pharo's distribution.

##### Task 3 Deliverables
 - A git repository with a tag named `task3`, fork of the chess repository, and containing all your improvements
 - A report of your work in a markdown file (`Task3.md`) in the root of that repository. The report should explain
     -  how you designed your grammar(s)
     -  what kind of mutations did you use and how did you implement them?
     -  what oracle did you choose and how did you implement them?
     -  The list of (unique) bugs you found

##### Task 3 Grading
Task 3 will be evaluated by the quality and thoroughness of your fuzzing ideas and your report explanations.
We will evaluate your fuzzers, your oracle implementations, and the bugs you found.
This accounts for 70% of the grade.

**Bonus 30% of the grade:** Combine your fuzzing with a fault localization technique, find the cause of *at least one bug* and *provide a fix*.

**Things that count negatively:** Broken code/scripts that cannot be used. Not finding a single bug and not explaining why.

