tests
testSingleTemplateNameWithoutBrackets
	| aSelection aContext  |
	
	aSelection := self newSelectionModelNamed: 'NodeA-#build1'.
	aContext := PhLCommandContext selection: aSelection imageRepository: nil templateRepository: nil.
	
	self assert: aContext singleTemplateName equals: 'NodeA-#build1'
