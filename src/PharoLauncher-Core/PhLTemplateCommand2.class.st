"
Superclass of all commands that are applied to one template or multiple templates.
"
Class {
	#name : #PhLTemplateCommand2,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #accessing }
PhLTemplateCommand2 >> templatesPresenter [
	^ self context
]
