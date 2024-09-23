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
					   square up ifNotNil: [ :p |
						   p up ifNotNil: [
							   {
								   p.
								   p up } ] ] ]
				   ifFalse: [ { square up } ] ]
		   ifFalse: [
			   (square name at: 2) = $7
				   ifTrue: [
					   square down ifNotNil: [ :p |
						   p down ifNotNil: [
							   {
								   p.
								   p down } ] ] ]
				   ifFalse: [ { square down } ] ]) select: [ :s |
		  s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ]
]
