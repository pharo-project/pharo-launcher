"
Superclass of all commands that are applied to one template or multiple templates.
"
Class {
	#name : #PhLTemplateCommand,
	#superclass : #PhLCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #testing }
PhLTemplateCommand class >> isAbstract [
	^ self name = 'PhLTemplateCommand'
]

{ #category : #testing }
PhLTemplateCommand >> isApplicable [
	^ super isApplicable and: [ self model hasSingleTemplateSelected ]
]
