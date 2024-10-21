Class {
	#name : 'MyGrammarFENFuzzer',
	#superclass : 'Object',
	#category : 'Myg-Chess-Importers',
	#package : 'Myg-Chess-Importers'
}

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzActiveColor [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	^ (1 to: 2) atRandom = 1 ifTrue: [ 'w' ] ifFalse: [ 'b' ].
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzCastlingAvailability [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| possibilities |
   	possibilities := OrderedCollection new.
   possibilities add: 'K'; add: 'Q'; add: 'k'; add: 'q'; add: '-'.
   
	^ possibilities asString.
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzEnPassant [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	^ (1 to: 2) atRandom = 1
            ifTrue: [ (String with: ($a to: $h) atRandom) , (1 to: 8) atRandom asString ]
            ifFalse: [ '-' ].
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzFEN [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	^ String streamContents: [ :stream |
  		stream nextPutAll: self fuzzPiecePlacement;
      	space;
      	nextPutAll: self fuzzActiveColor;
      	space;
      	nextPutAll: self fuzzCastlingAvailability;
      	space;
      	nextPutAll: self fuzzEnPassant;
      	space;
      	nextPutAll: self fuzzHalfMove;
      	space;
      	nextPutAll: self fuzzFullMove.
   	].
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzFullMove [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	^ (1 to: 100) atRandom asString.
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzHalfMove [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	^ (1 to: 50) atRandom asString.

]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzPiecePlacement [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| rows|
	rows := (1 to: 8) collect: [ :i | self fuzzRank asString ].
   
	^ String streamContents: [ :stream |
            rows do: [ :each |
                stream nextPutAll: each asString.
                rows last = each ifFalse: [ stream nextPut: $/ ].
            ].
   ].
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> fuzzRank [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| pieces |
   pieces := OrderedCollection new.
   1 to: 8 do: [ :i | 
		(1 to: 2) atRandom = 1
      		ifTrue: [ pieces add: self randomPiece ]
         ifFalse: [ pieces add: (1 to: 8) atRandom asString ].
   ].
        
	^ pieces asString
]

{ #category : 'as yet unclassified' }
MyGrammarFENFuzzer >> randomPiece [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	| pieces |
	pieces := 'rnbqkpRNBQKP'.
	
	^ (pieces atRandom) asString.
]
