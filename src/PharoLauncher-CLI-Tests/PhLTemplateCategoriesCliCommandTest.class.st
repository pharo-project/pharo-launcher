Class {
	#name : #PhLTemplateCategoriesCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateCategoriesCliCommandTest >> testTemplateCategoriesShouldSucceed [

	self runCommand: #('launcher' 'template' 'categories').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring: 'Local test templates') 
]
