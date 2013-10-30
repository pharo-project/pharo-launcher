instance creation
newFromJson: aJsonObject 
	^ self new
		initializeFromJson: aJsonObject;
		yourself