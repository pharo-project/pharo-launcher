testing
isApplicable
	^ super isApplicable and: [ self model hasSingleImageSelected ]