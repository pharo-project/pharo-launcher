items creation
buildList: aString

	| list |
	list := OrderedCollection new.
	self listElement do:[ :each |
		| tmpString |
		tmpString := each name.
		( (tmpString endsWith: '.image') & (each category asString = aString) )
			ifTrue: [ list add: tmpString ]
			].
	^list sorted: [:a :b | a name < b name].