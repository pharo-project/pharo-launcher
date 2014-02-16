testing
isNewImageNameValid: aString 
	^ aString isEmptyOrNil not and: [ (self hasImageNamed: aString) not ]