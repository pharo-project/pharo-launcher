Class {
	#name : #PhLTemplateMock,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #'instance creation' }
PhLTemplateMock class >> named: aName [
	^ self new name:aName.
]

{ #category : #'instance initialization' }
PhLTemplateMock >> name [
	^ name
]

{ #category : #'instance initialization' }
PhLTemplateMock >> name: aName [
	 name:= aName.
]
