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
