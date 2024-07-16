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

#### Task 2: manual testing and refactoring

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

