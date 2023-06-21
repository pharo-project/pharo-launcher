Extension { #name : #StringTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
StringTest >> testShortenTo [

	self assert: ('ABCDEF' shortenTo: 0) equals: ' ... '.
	self assert: ('ABCDEF' shortenTo: 5) equals: ' ... '.
	self assert: ('ABCDEF' shortenTo: 6) equals: 'ABCDEF'.
	self assert: ('ABCDEF' shortenTo: 7) equals: 'ABCDEF'.
	self assert: ('ABCDEFGHIJ' shortenTo: 9) equals: 'A ... HIJ'.
	self assert: ('ABCDEFGHIJK' shortenTo: 10) equals: 'AB ... IJK'.
]
