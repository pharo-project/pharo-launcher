"
Image repository which use a filesystem in memory used for the tests. 
"
Class {
	#name : #PhLTestImageRepository,
	#superclass : #PhLDirectoryBasedImageRepository,
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #initialization }
PhLTestImageRepository >> createImageNamed: aName [
	^ self createImageNamed: aName in:  (self baseDirectory / aName)
	

]

{ #category : #initialization }
PhLTestImageRepository >> createImageNamed: aName in: aFolder [
	| imageFile |
	imageFile := aFolder / (aName , '.image').
	aFolder ensureCreateDirectory.
	imageFile binaryWriteStreamDo: [:stream | stream nextPutAll: #(105 25 0 0)].
	(aFolder / (aName , '.changes')) ensureCreateFile.
	(aFolder / PhLImage versionFileName) writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	^ imageFile

]

{ #category : #testing }
PhLTestImageRepository >> hasImageOnFileSystemNamed: aName [
	^ self baseDirectory / aName / (aName , '.image')
]

{ #category : #initialization }
PhLTestImageRepository >> initialize [

	super initialize.
	self setBaseDirectory: FileSystem memory root.
	self createImageNamed: self singleImageName.
	

]

{ #category : #initialization }
PhLTestImageRepository >> singleImageName [
	^ 'TestImage'
	

]
