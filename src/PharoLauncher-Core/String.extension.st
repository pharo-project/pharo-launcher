Extension { #name : #String }

{ #category : #'*PharoLauncher-Core' }
String >> asLegalSelector [
	"'234znak 43 ) 2' asLegalSelector"
	
	| toUse |
 	toUse := self select: [:char | char isAlphaNumeric].
	(toUse size = 0 or: [ toUse first isLetter not ])
		ifTrue: [ toUse := 'v', toUse ].
	^ toUse uncapitalized asSymbol.
]

{ #category : #'*PharoLauncher-Core' }
String >> formatTemplateName: aUrlString [
	"Format the receiver by interpolating elements from url string path segments, as in the following examples:" 
	"('{6} ({5})' formatTemplateName: '/pharo-ide/TelePharo/releases/download/v0.4.2/Pharo7.0-32bit-TelePharo.zip') >>> 'Pharo7.0-32bit-TelePharo (v0.4.2)'"
	"We always remove the extension of the last segment ('.zip)"
	| segments |
	segments:= aUrlString asZnUrl segments.

	^ self class
		new: self size
		streamContents: [ :result | 
			| stream |
			stream := self readStream.
			[ stream atEnd ]
				whileFalse: [ | currentChar |
					(currentChar := stream next) == ${
						ifTrue: [ | expression index value |
							expression := stream upTo: $}.
							index := Integer readFrom: expression ifFail: [ expression ].
							value := segments at: index.
							result nextPutAll: (index = segments size ifTrue: [ value copyUpToLast: $. ] ifFalse: [ value ]) ]
						ifFalse: [ currentChar == $\
								ifTrue: [ stream atEnd
										ifFalse: [ result nextPut: stream next ] ]
								ifFalse: [ result nextPut: currentChar ] ] ] ]
]
