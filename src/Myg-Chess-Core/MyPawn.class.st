Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	| results |
	results := #().

	(self isWhite
		   ifTrue: [
			   (square name at: 2) = $2
				   ifTrue: [
					   (square up) ifNotNil: [ :p | p up ifNotNil: [ :secondUp | results := results copyWith: p. secondUp hasPiece ifFalse: [ results := results copyWith: secondUp ] ] ]
					]
				   ifFalse: [ 
						(square up) ifNotNil: [ :p | p hasPiece ifFalse: [ results := results copyWith: p ]].
						(square up) ifNotNil: [ :p | p right ifNotNil: [ :upRight | upRight hasPiece and: [ upRight contents color ~= color ifTrue: [ results := results copyWith: upRight ] ] ] ].
						(square up) ifNotNil: [ :p | p left ifNotNil: [ :upLeft | upLeft hasPiece and: [ upLeft contents color ~= color ifTrue: [ results := results copyWith: upLeft ] ] ] ]
					]
			]
		   ifFalse: [
			   (square name at: 2) = $7
				   ifTrue: [
					   (square down) ifNotNil: [ :p | p down ifNotNil: [ :secondDown | results := results copyWith: p. secondDown hasPiece ifFalse: [ results := results copyWith: secondDown ] ] ] 
					]
				   ifFalse: [ 
						(square down) ifNotNil: [ :p | p hasPiece ifFalse: [ results := results copyWith: p ] ].
						(square down) ifNotNil: [ :p | p right ifNotNil: [ :downRight | downRight hasPiece and: [ downRight contents color ~= color ifTrue: [ results := results copyWith: downRight ] ] ] ].
						(square down) ifNotNil: [ :p | p left ifNotNil: [ :downLeft | downLeft hasPiece and: [ downLeft contents color ~= color ifTrue: [ results := results copyWith: downLeft ] ] ] ]
					]
			]
		).
		
		^ results
]
