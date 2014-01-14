testing
isApplicable
	^ super isApplicable and: [ context hasSingleTemplateSelected ]