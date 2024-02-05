Extension { #name : #StringTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
StringTest >> testShortenTo [
	|shortened|
	shortened := String new shortForm.
	self assert: ('ABCDEF' shortenTo: 0) equals: shortened.
	self assert: ('ABCDEF' shortenTo: 5) equals: shortened.
	self assert: ('ABCDEF' shortenTo: 6) equals: 'ABCDEF'.
	self assert: ('ABCDEF' shortenTo: 7) equals: 'ABCDEF'.
	self assert: ('ABCDEFGHIJ' shortenTo: 9) equals: 'A', shortened, 'HIJ'.
	self assert: ('ABCDEFGHIJK' shortenTo: 10) equals: 'AB', shortened, 'IJK'.
]
