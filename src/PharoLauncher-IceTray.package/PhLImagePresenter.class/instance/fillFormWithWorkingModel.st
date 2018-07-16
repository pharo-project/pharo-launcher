initialization
fillFormWithWorkingModel

	self workingModel ifNil: [ ^ self ].

	self nameTextInput text: self workingModel name asString.
	self vmInput text: self workingModel vm asString.	
	self templateInput text: self workingModel template asString.	
	self lastModificationInput text: self workingModel lastModification asString.	
	self tagsInput text: 'no tags support'.
	self commentInput text: 'no comments support'.
	self locationInput text: 'no location support'.

	