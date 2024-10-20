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

	^ (self isWhite
		   ifTrue: [
			   (square name at: 2) = $2
				   ifTrue: [
					   (square up) ifNotNil: [ :p | p up ifNotNil: [ p up hasPiece ifFalse: [ { p . p up } ] ifTrue: [ { p } ] ] ]
					]
				   ifFalse: [ 
						(square up) ifNotNil: [ :p | p hasPiece ifFalse: [ { p } ] ifTrue: [ {  } ] ]
					]
			]
		   ifFalse: [
			   (square name at: 2) = $7
				   ifTrue: [
					   (square down) ifNotNil: [ :p | p down ifNotNil: [ p down hasPiece ifFalse: [ { p . p down } ] ifTrue: [ { p } ] ] ] 
					]
				   ifFalse: [ 
						(square down) ifNotNil: [ :p | p hasPiece ifFalse: [ { p } ] ifTrue: [ {  } ] ]
					]
			]
		) select: [ :s | s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ]
]
