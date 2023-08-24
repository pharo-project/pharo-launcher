"
Error thrown when a template (zip archive) is corrupted
"
Class {
	#name : #PhLCorruptedTemplateError,
	#superclass : #PhLError,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLCorruptedTemplateError >> longDescription [

	^ self name
]

{ #category : #accessing }
PhLCorruptedTemplateError >> name [
	^ 'This template appears to be corrupted! Please try again.'
]
