"
A PhLCommandContextTest is a test class for testing the behavior of PhLCommandContext
"
Class {
	#name : #PhLCommandContextTest,
	#superclass : #TestCase,
	#category : 'PharoLauncher-Tests-SpecUI'
}

{ #category : #utility }
PhLCommandContextTest >> newSelectionModelNamed: aNameString [
	| aSelection aNode |
	
	aNode := PhLRemoteTemplate name: aNameString url: ''.
	aSelection := PhLTreeSelection
		with:
			{(TreeNodePresenter new
				content: aNode;
				parentNode: (TreeNodePresenter new content: #parent);
				yourself)}.
				
	^ aSelection
]

{ #category : #tests }
PhLCommandContextTest >> testSingleTemplateNameWithBracketsTruncates [
	| aSelection aContext |
	
	aSelection := self newSelectionModelNamed: 'NodeA-#build1-(versionInfo)-(releaseInfo)'.
	aContext := PharoLauncherModel selection: aSelection imageRepository: nil templateRepository: nil.
	
	self assert: aContext singleTemplateName equals: 'NodeA-#build1'
]

{ #category : #tests }
PhLCommandContextTest >> testSingleTemplateNameWithoutBrackets [
	| aSelection aContext  |
	
	aSelection := self newSelectionModelNamed: 'NodeA-#build1'.
	aContext := PharoLauncherModel selection: aSelection imageRepository: nil templateRepository: nil.
	
	self assert: aContext singleTemplateName equals: 'NodeA-#build1'

]
