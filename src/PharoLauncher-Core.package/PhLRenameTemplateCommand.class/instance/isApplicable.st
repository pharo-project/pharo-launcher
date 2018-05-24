testing
isApplicable
	^ super isApplicable and: [ context hasSingleLocalTemplateSelected ]