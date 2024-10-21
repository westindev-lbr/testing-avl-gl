Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testLegalMoves [

	| king board squares|
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	squares := king basicTargetSquares.
	
	self assertCollection: squares 
		includesAll: (#( d5 e5 f5 f4 d4 d3 e3 f3) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyKingTest >> testMoveWithSameColorObstacle [
	
	| king squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).
	
	board at: 'f4' put: MyBishop white.
	board at: 'd4' put: MyPawn white.
	board at: 'e5' put: MyPawn white.
	board at: 'e3' put: MyPawn white.

	squares := king targetSquaresLegal: false.
	
	self assertCollection: squares 
		includesAll: (#( d5 f5 d3 f3) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyKingTest >> testMoveWithSameColorObstacleBis [
	
	| king squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).
	
	board at: 'f5' put: MyBishop white.
	board at: 'd5' put: MyPawn white.
	board at: 'f3' put: MyPawn white.
	board at: 'd3' put: MyPawn white.

	squares := king targetSquaresLegal: false.
	
	self assertCollection: squares 
		includesAll: (#( e5 f4 d4 e3 ) collect: [ :name |
				 board at: name ])
]
