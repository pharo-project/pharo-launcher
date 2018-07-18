testing
isNewLocalTemplateNameValid: aString 
	^ aString isEmptyOrNil not and: [ (self hasTemplateNamed: aString) not ]