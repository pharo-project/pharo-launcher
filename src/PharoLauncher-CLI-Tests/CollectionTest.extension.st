Extension { #name : #CollectionTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
CollectionTest >> testGetMaxWithOn [

	|printBlock|
	printBlock := [ :aNumber | aNumber asWords ].
	"three is a longest word of size 5"
	self assert: (#(1 2 3) getMaxWidthOn: printBlock) equals: 5.
]
