tests
testSingleTemplateNameWithBracketsTruncates
	| aSelection aContext |
	
	aSelection := self newSelectionModelNamed: 'NodeA-#build1-(versionInfo)-(releaseInfo)'.
	aContext := PhLCommandContext selection: aSelection imageRepository: nil templateRepository: nil.
	
	self assert: aContext singleTemplateName equals: 'NodeA-#build1'