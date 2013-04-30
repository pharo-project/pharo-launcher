items creation
buildList: aString
	| list |
	self halt.
	list := OrderedCollection new.
	self listElement do:[ :each |
		(each category asString = aString) 
			ifTrue: [ list add: (each name) asString ] ].
	self halt.
	^list sorted: [:a :b | a name < b name].