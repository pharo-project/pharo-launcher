"
Only usefull for the tests, is usefull to create ""fake"" images. 
"
Class {
	#name : #PhLImageMock,
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
PhLImageMock class >> atRandom [ 
   ^self new 
		name: #( 'Image (PharoX.0.0-rc1.build.1436.sha.e281eb4.arch.64bit)'
					'Image (Pharo x.0 - xybit -exe)' 
					'Image (P-test)' 'Image (Pharo Mooc)' 
					'Image (P1-64b-seaside)' 
					'Image (Pharo 9.0 (stable))') atRandom;
		architecture: #('32' '64') atRandom;
		pharoVersion: #('60' '61' '70' '80' '90' '100') atRandom;
		lastModification: (DateAndTime fromUnixTime: (1 to: 1600000000) atRandom );
yourself 
]

{ #category : #private }
PhLImageMock class >> listPrintAttributeBlocks [
	
	^ PhLImage listPrintAttributeBlocks
]

{ #category : #private }
PhLImageMock class >> listPrintAttributeLabels [ 
	
	^ PhLImage listPrintAttributeLabels 
]

{ #category : #'instance creation' }
PhLImageMock class >> location: aFileReference [
	^ self atRandom
		setLocation: aFileReference;
		yourself
]

{ #category : #accessing }
PhLImageMock class >> name: aString [
	^ self atRandom
		name: aString;
		yourself
]

{ #category : #accessing }
PhLImageMock >> architecture [
	^ '64'
]

{ #category : #accessing }
PhLImageMock >> architecture: aString [

	architecture := aString
]

{ #category : #mocking }
PhLImageMock >> checkImageArchitecture [
	^self 
]

{ #category : #accessing }
PhLImageMock >> description [ 
	^ 'this is the description'
]

{ #category : #mocking }
PhLImageMock >> ensureDefaultConfiguration [
	^self
]

{ #category : #testing }
PhLImageMock >> hasInitializationScript [
	^ script notNil 
]

{ #category : #accessing }
PhLImageMock >> initializationScript [
	^ script 
]

{ #category : #preparation }
PhLImageMock >> initializationScript: aFileReference [
	 script := aFileReference
]

{ #category : #mocking }
PhLImageMock >> initialize [ 
	super initialize.
	isLaunched := false.
]

{ #category : #mocking }
PhLImageMock >> isLaunched [
	^ isLaunched
]

{ #category : #accessing }
PhLImageMock >> lastModification [
	^ lastModification 
]

{ #category : #accessing }
PhLImageMock >> lastModification: aString [
	
	lastModification := aString
]

{ #category : #mocking }
PhLImageMock >> launch [
	isLaunched := true
]

{ #category : #accessing }
PhLImageMock >> location [
	^ 'my current location'
]

{ #category : #accessing }
PhLImageMock >> name [
   ^name
]

{ #category : #accessing }
PhLImageMock >> name: aString [
   name := aString
]

{ #category : #accessing }
PhLImageMock >> originTemplateName [
	^ 'the original template name'
]

{ #category : #accessing }
PhLImageMock >> originTemplateUrl [
	^ 'https://testurl'
]

{ #category : #accessing }
PhLImageMock >> pharoVersion [

	^ pharoVersion
]

{ #category : #accessing }
PhLImageMock >> pharoVersion: aString [

	pharoVersion := aString
]

{ #category : #accessing }
PhLImageMock >> pharoVersionFromFile [
	^ 'Pharo 8'
]

{ #category : #initialization }
PhLImageMock >> setLocation: aFileReference [ 
	location := aFileReference.
]

{ #category : #mocking }
PhLImageMock >> shouldRunInitializationScript: aTrue [ 
	^ self 
]

{ #category : #mocking }
PhLImageMock >> vmManager [
	^self 
]
