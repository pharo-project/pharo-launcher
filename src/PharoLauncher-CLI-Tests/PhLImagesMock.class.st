"
Only usefull for the tests, is usefull to create ""fake"" images. 
"
Class {
	#name : #PhLImagesMock,
	#superclass : #Object,
	#instVars : [
		'images',
		'name',
		'isLaunched',
		'script',
		'location'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #'instance creation' }
PhLImagesMock class >> location: aFileReference [
	^ PhLImagesMock new
		setLocation: aFileReference;
		yourself
]

{ #category : #accessing }
PhLImagesMock class >> name: aString [
   ^self new name: aString.
]

{ #category : #mocks }
PhLImagesMock >> architecture [
	^ '64'
]

{ #category : #mockup }
PhLImagesMock >> checkImageArchitecture [
	^self 
]

{ #category : #printing }
PhLImagesMock >> cliPrintOn: aStream [
	aStream
		nextPutAll: self name;
		tab;
		nextPutAll: 'architecture: ';
		nextPutAll: self architecture.
]

{ #category : #accessing }
PhLImagesMock >> description [ 
	^ 'this is the description'
]

{ #category : #mock }
PhLImagesMock >> ensureDefaultConfiguration [
	^self
]

{ #category : #testing }
PhLImagesMock >> hasInitializationScript [
	^ script notNil 
]

{ #category : #accessing }
PhLImagesMock >> initializationScript [
	^ script 
]

{ #category : #preparation }
PhLImagesMock >> initializationScript: aFileReference [
	 script := aFileReference
]

{ #category : #mock }
PhLImagesMock >> initialize [ 
	super initialize.
	isLaunched := false.
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

{ #category : #initialization }
PhLImagesMock >> setLocation: aFileReference [ 
	location := aFileReference.
]

{ #category : #mocking }
PhLImagesMock >> shouldRunInitializationScript: aTrue [ 
	^ self 
]

{ #category : #'mocking world' }
PhLImagesMock >> vmManager [
	^self 
]
