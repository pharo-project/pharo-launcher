Class {
	#name : #PhLTemplateListCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateShouldSucceed [
	
	self runCommand: #('launcher' 'template' 'list').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'Pharo')
]

{ #category : #tests }
PhLTemplateListCliCommandTest >> testListTemplateWithCategoryShouldSucceed [
	
	self runCommand: #('launcher' 'template' 'list' '--templateCategory' 'Pharo Mooc').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring:'Pharo')
]
