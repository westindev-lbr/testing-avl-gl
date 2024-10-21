Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#instVars : [
		'statements'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testFirstMoveBlackPawn [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"
	
	"should move forward of 2 cases if state of board is initial"
	
	| board tpawn squares |
	board := MyChessBoard empty.
	board at: 'a7' put: (tpawn := MyPawn black).
	
	squares := tpawn targetSquares.
	
	self
		assertCollection: squares
		includesAll:
			(#( a6 a5 ) collect: [ :name |
				 board at: name ])
	

	
]

{ #category : 'tests' }
MyPawnTests >> testFirstMoveWhitePawn [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"
	
	"should move forward of 2 cases if state of board is initial"
	
	| board tpawn squares |
	board := MyChessBoard empty.
	board at: 'a2' put: (tpawn := MyPawn white).
	
	squares := tpawn targetSquares.
	
	self
		assertCollection: squares
		includesAll:
			(#( a3 a4 ) collect: [ :name |
				 board at: name ])
	

	
]

{ #category : 'tests' }
MyPawnTests >> testId [
	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTests >> testIllegalMoveWhenHasPieceInFront [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| board wpawn bpawn wsquares bsquares |
	board := MyChessBoard empty.
	board at: 'c4' put: (wpawn := MyPawn white).
	board at: 'c5' put: (bpawn := MyPawn black).
	
	wsquares := wpawn targetSquares.
	bsquares := bpawn targetSquares.
	
	self assert: wsquares isEmpty equals: true.
	self assert: bsquares isEmpty equals: true.	
]

{ #category : 'tests' }
MyPawnTests >> testMoveDiagonnalyToCapturePieces [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| board wpawn bpawn bpawn2 wsquares bsquares |
	board := MyChessBoard empty.
	board at: 'c4' put: (wpawn := MyPawn white).
	board at: 'd5' put: (bpawn := MyPawn black).
	board at: 'b5' put: (bpawn2 := MyPawn black).
	
	wsquares := wpawn targetSquares.
	bsquares := bpawn targetSquares.
	
	self assertCollection: wsquares includesAll: (#( d5 c5 b5) collect: [ :name | board at: name ]).
	self assertCollection: bsquares includesAll: (#( c4 d4 ) collect: [ :name | board at: name ]).
]

{ #category : 'tests' }
MyPawnTests >> testMoveDiagonnalyToCapturePiecesSameColor [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| board wpawn wpawn2 wpawn3 wsquares |
	board := MyChessBoard empty.
	board at: 'd4' put: (wpawn := MyPawn white).
	board at: 'e3' put: (wpawn2 := MyPawn white).
	board at: 'f4' put: (wpawn3 := MyPawn white).
	
	wsquares := wpawn2 targetSquares.
	
	self assertCollection: wsquares includesAll: (#( e4 ) collect: [ :name | board at: name ]).

]

{ #category : 'tests' }
MyPawnTests >> testPawnRenderPieceOn [

	| pawn square |
	pawn := MyPawn white.
	square := MyChessSquare black.
	
	self assert: (pawn renderPieceOn: square) equals: 'p'. 
]
