"
Only usefull for the tests, is usefull to create ""fake"" images. 
"
Class {
	#name : #PhLImagesMock,
	#superclass : #Object,
	#instVars : [
		'images',
		'name',
		'launchCheck',
		'isLaunched'
	],
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #accessing }
PhLImagesMock class >> name: aString [
   ^self new name: aString.
]

{ #category : #mock }
PhLImagesMock >> ensureDefaultConfiguration [
	^self
]

{ #category : #mock }
PhLImagesMock >> initialize [ 
	super initialize.
	isLaunched := false
]

{ #category : #mock }
PhLImagesMock >> isLaunched [
	^ isLaunched
]

{ #category : #mock }
PhLImagesMock >> launch [
	isLaunched := true
]

{ #category : #accessing }
PhLImagesMock >> name [
   ^name
]

{ #category : #accessing }
PhLImagesMock >> name: aString [
   name := aString
]
