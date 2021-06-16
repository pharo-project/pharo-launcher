Class {
	#name : #PhLTemplateInfoCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLTemplateInfoCliCommandTest >> addLocalTemplateNamed: aName [ 
	^ context launcherModel templateBaseRepository createLocalTemplateNamed: aName
]

{ #category : #tests }
PhLTemplateInfoCliCommandTest >> testTemplateInfoShouldSucceed [
	self addLocalTemplateNamed: 'fakeTemplate'.
	
	self runCommand: #('launcher' 'template' 'info' 'fakeTemplate' '--templateCategory' 'Local test templates').
	
	self assertSuccess.
	self assert: self outputString equals:''
	
]
