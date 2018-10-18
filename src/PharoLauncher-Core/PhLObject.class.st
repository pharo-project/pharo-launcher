"
Super class of everything the user can act on
"
Class {
	#name : #PhLObject,
	#superclass : #Object,
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLObject >> children [
	^ #()
]

{ #category : #testing }
PhLObject >> hasChildren [
	^ true
]

{ #category : #testing }
PhLObject >> isImage [
	^ false
]

{ #category : #testing }
PhLObject >> isTemplate [
	^ false
]

{ #category : #testing }
PhLObject >> isTemplateGroup [
	^ false
]
