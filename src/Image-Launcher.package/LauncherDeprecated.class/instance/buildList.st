items creation
buildList
	| list |
	list := OrderedCollection new.
	self dictionary do:[ :each |
		list add: (self dictionary keyAtValue: each) asString].
	^list sorted: [:a :b | a name < b name].