adding
addEntry: aDictionary
	|container|
	container := PanelMorph new.
	aDictionary do:[ :each |
		container add: (builder newButtonFor: self
			action: nil
			label: (aDictionary keyAtValue: each) asString
			help: each asString).].
	^builder newColumn: {
		container
		}