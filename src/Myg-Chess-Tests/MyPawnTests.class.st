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
