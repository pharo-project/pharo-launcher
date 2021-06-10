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
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
PhLImagesMock class >> name: aString [
   ^self new name: aString.
]

{ #category : #accessing }
PhLImagesMock >> description [ 
	^ 'this is the description'
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

{ #category : #accessing }
PhLImagesMock >> lastModification [
	^ 'some random date'
]

{ #category : #mock }
PhLImagesMock >> launch [
	isLaunched := true
]

{ #category : #accessing }
PhLImagesMock >> location [
	^ 'my current location'
]

{ #category : #accessing }
PhLImagesMock >> name [
   ^name
]

{ #category : #accessing }
PhLImagesMock >> name: aString [
   name := aString
]

{ #category : #accessing }
PhLImagesMock >> originTemplateName [
	^ 'the original template name'
]

{ #category : #accessing }
PhLImagesMock >> originTemplateUrl [
	^ 'https://testurl'
]

{ #category : #accessing }
PhLImagesMock >> pharoVersionFromFile [
	^ 'Pharo 8'
]
