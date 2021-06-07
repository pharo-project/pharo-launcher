"
Superclass of all commands that are applied to one template or multiple templates.
"
Class {
	#name : #PhLTemplateCommand,
	#superclass : #CmCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLTemplateCommand >> application [

	^ self context application
]

{ #category : #accessing }
PhLTemplateCommand >> templatesPresenter [
	^ self context
]
