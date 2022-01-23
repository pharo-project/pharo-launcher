"
Only usefull for the tests, is usefull to create ""fake"" images. 
"
Class {
	#name : #PhLImagesMock,
	#superclass : #Object,
	#instVars : [
		'name',
		'architecture',
		'isLaunched',
		'location',
		'script',
		'pharoVersion',
		'lastModification'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
PhLImagesMock class >> atRandom [ 
   ^self new 
		name: #('Image (PharoX.0.0-rc1.build.1436.sha.e281eb4.arch.64bit)' 'Image (Pharo x.0 - xybit -exe)' 'Image (P-test)' 'Image (Pharo Mooc)' 'Image (P1-64b-seaside)' 'Image (Pharo 9.0 (stable))') atRandom;
		architecture: #('32' '64') atRandom;
		pharoVersion: #('60' '61' '70' '80' '90' '100') atRandom;
		lastModification: (DateAndTime fromUnixTime: (1 to: 1600000000) atRandom );
yourself 
]

{ #category : #private }
PhLImagesMock class >> listPrintAttributeBlocks [
	
	^ PhLImage listPrintAttributeBlocks
]

{ #category : #private }
PhLImagesMock class >> listPrintAttributeLabels [ 
	
	^ PhLImage listPrintAttributeLabels 
]

{ #category : #'instance creation' }
PhLImagesMock class >> location: aFileReference [
	^ self atRandom
		setLocation: aFileReference;
		yourself
]

{ #category : #accessing }
PhLImagesMock class >> name: aString [
	^ self atRandom
		name: aString;
		yourself
]

{ #category : #accessing }
PhLImagesMock >> architecture [
	^ '64'
]

{ #category : #accessing }
PhLImagesMock >> architecture: aString [

	architecture := aString
]

{ #category : #mockup }
PhLImagesMock >> checkImageArchitecture [
	^self 
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
	^ lastModification 
]

{ #category : #accessing }
PhLImagesMock >> lastModification: aString [
	
	lastModification := aString
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
PhLImagesMock >> pharoVersion [

	^ pharoVersion
]

{ #category : #accessing }
PhLImagesMock >> pharoVersion: aString [

	pharoVersion := aString
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
