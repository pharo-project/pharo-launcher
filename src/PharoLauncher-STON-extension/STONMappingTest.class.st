Class {
	#name : #STONMappingTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-STON-extension'
}

{ #category : #tests }
STONMappingTest >> stonStringOf: anObject with: aWriterClass [

	^ String streamContents: [ :stream |
		(aWriterClass new on: stream)
			prettyPrint: true; 
			nextPut: anObject ].
]

{ #category : #tests }
STONMappingTest >> testObjetReadWithMappingIsHonored [
	| stonString result |
	stonString := 'STONTestDomainObjectWithMapping {
	#integer : 348525,
	#color : Color [ #red ] }'.
	
	result := (STONReaderWithMapping new on: stonString readStream) next.
	
	self 
		assert: result color isString
]

{ #category : #tests }
STONMappingTest >> testObjetWithNoMappingReadSameThingAsStonReader [
	|  result stonString expected |
	stonString := 'TestDomainObject {
	#integer : 348525,
	#color : Color [ #red ] }'.
	
	result := (STONReaderWithMapping new on: stonString readStream) next.
	
	expected := (STONReader new on: stonString readStream) next.
	
	self assert: result color equals: expected color.
	self assert: result integer equals: expected integer.
]

{ #category : #tests }
STONMappingTest >> testObjetWithNoMappingWriteSameThingAsStonWriter [
	| object stonString |
	object := STONTestDomainObject dummy.
	
	stonString :=  self stonStringOf: object with: STONWriterWithMapping.
	
	self assert: stonString equals: (self stonStringOf: object with: STONWriter)
]

{ #category : #tests }
STONMappingTest >> testObjetWriteWithMappingIsHonored [
	| object stonString |
	object := STONTestDomainObjectWithMapping dummy.
	
	stonString :=  self stonStringOf: object with: STONWriterWithMapping.
	
	self 
		assert: (STON fromString: stonString) color class
		equals: Color
]

{ #category : #tests }
STONMappingTest >> testPhLImageSerialization [
	| image stonString |
	image := PhLImage example.
	(image file parent / image class versionFileName)
		writeStreamDo: [ :stream | stream nextPutAll: '80' ].
	image launchConfigurations.
	image defaultLaunchConfiguration vm.
	image vmManager imageFile: FileLocator documents / 'Pharo' / 'images' / (image name , '.image').
	
	stonString := image stonString.
	
	"ensure we get a file locator"
	self assert: (stonString includesSubstring: '#executableRef : FileLocator {
					#origin : #launcherUserFilesLocation,
					#path : RelativePath [ ''vms'', ''80-x64''').
	"ensure VM manager is a reference"
	self assert: (stonString includesSubstring: '#manager : @2,').
]
