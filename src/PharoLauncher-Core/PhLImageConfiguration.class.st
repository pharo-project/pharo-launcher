Class {
	#name : #PhLImageConfiguration,
	#superclass : #PhLObject,
	#instVars : [
		'name',
		'vm'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #accessing }
PhLImageConfiguration >> initialize [

	super initialize.
	name := 'new configuration...'.
	vm := PhLDefaultVM new
]

{ #category : #accessing }
PhLImageConfiguration >> name [
	
	^ name
]

{ #category : #accessing }
PhLImageConfiguration >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PhLImageConfiguration >> vm [
	
	^ vm
]

{ #category : #accessing }
PhLImageConfiguration >> vm: aVM [ 
	vm := aVM
]
