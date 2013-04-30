items creation
buildList: aString
	| list |
	
	list := OrderedCollection new.
	self listElement do:[ :each |
		(each category asString = aString) 
			ifTrue: [ list add: (each name) asString ] ].
	
	^list sorted: [:a :b | a name < b name].