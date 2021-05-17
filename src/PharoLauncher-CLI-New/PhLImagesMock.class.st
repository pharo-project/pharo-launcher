"
Only usefull for the tests, is usefull to create ""fake"" images. 
"
Class {
	#name : #PhLImagesMock,
	#superclass : #Object,
	#instVars : [
		'images',
		'name',
		'launchCheck'
	],
	#category : #'PharoLauncher-CLI-New'
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
PhLImagesMock >> launch [
	self launchCheck: 'True'.
]

{ #category : #'inst var' }
PhLImagesMock >> launchCheck [
	^launchCheck
]

{ #category : #'inst var' }
PhLImagesMock >> launchCheck: aString [
	launchCheck := aString
]

{ #category : #accessing }
PhLImagesMock >> name [
   ^name
]

{ #category : #accessing }
PhLImagesMock >> name: aString [
   name := aString
]
