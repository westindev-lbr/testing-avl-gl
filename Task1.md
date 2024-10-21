# Rapport Task1 - AVL

## KATA 1

Fix pawn moves!
Goal: Practice debugging and testing

Pawns are one of the most complicated pieces of chess to implement. They move forward, one square at a time, except for their first movement. However, they can move diagonally to capture other pieces. And in addition, there is the (in)famous "En passant" move that complicates everything (see <https://en.wikipedia.org/wiki/En_passant>, and the FEN documentation for ideas on how to encode this information <https://www.chessprogramming.org/Forsyth-Edwards_Notation#En_passant_target_square>). As any complicated feature, the original developer (Guille P) left this for the end, and then left the project. But you can do it.

Questions and ideas that can help you in the process:

Can you write tests showing the bugs?
What kind of tools can you use to spot the bug?
Can you approach this incrementally? This is, splitting this task in many subtasks. How would you prioritize them?

---

En éxécutant le projet Chess, j'ai remarqué des bugs sur les déplacements des pions et la capture en diagonnale des pions adverses.
J'ai donc commencé par créer des tests dans la classe de test : `MyPawnTests`

* `TestFirstMoveBlackPawn` & `TestFirstMoveWhitePawn`
Il s'agit de deux tests qui vérifient si les pions étant sur leur ligne de départ ont la possiblité de se déplacer de 1 ou 2 cases en avant.

* `TestIllegalMoveWhenHasPieceInFront`
Ce test vérifie que si une pièce se trouve devant lui, il ne peut pas le capturer en avant.

* `TestMoveDiagonnalyToCapturePieces`
Ce test vérifie la possibilité pour un pion de capturer une pièce adverse en diagonnale avant.

## Refactorisation

Pour faire passer mes tests j'ai donc modifié la méthode `targetSquaresLegal:` de la classe `MyPawn`

## Remarque

J'ai décelé un autre bug de fonctionnalité non couvert par mes tests qui est : l'impossibilité de capturer une pièce adverse depuis leur ligne de départ.
