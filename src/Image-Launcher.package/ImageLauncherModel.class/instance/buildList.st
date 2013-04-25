items creation
buildList
	| list |
	list := OrderedCollection new.
	self listElement do:[ :each |
		list add: (each name) asString].
	^list sorted: [:a :b | a name < b name].