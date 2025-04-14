Class {
	#name : 'PhLTemplateCategoriesCliCommandTest',
	#superclass : 'PhLTemplatesCliCommandTest',
	#category : 'PharoLauncher-CLI-Tests-Commands',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Commands'
}

{ #category : 'tests' }
PhLTemplateCategoriesCliCommandTest >> testTemplateCategoriesShouldSucceed [

	self runCommand: #('launcher' 'template' 'categories').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring: self templateRepository localTemplatesGroupName) 
]
