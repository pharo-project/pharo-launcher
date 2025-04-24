"
Image repository which use a filesystem in memory used for the tests. 
"
Class {
	#name : 'PhLTestImageRepository',
	#superclass : 'PhLDirectoryBasedImageRepository',
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'initialization' }
PhLTestImageRepository >> createImageNamed: aName [
	^ self createImageNamed: aName in:  (self baseDirectory / aName)
	

]

{ #category : 'initialization' }
PhLTestImageRepository >> createImageNamed: aName in: aFolder [
	| imageFile |
	imageFile := aFolder / (aName , '.image').
	aFolder ensureCreateDirectory.
	imageFile binaryWriteStreamDo: [:stream | 
		(ZnEndianessReadWriteStream on: stream ) 
			nextLittleEndianNumber: 4 
			put: PhLVirtualMachineManager imageFormat64bits ].
	(aFolder / (aName , '.changes')) ensureCreateFile.
	(aFolder / PhLImage versionFileName) writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	^ imageFile

]

{ #category : 'testing' }
PhLTestImageRepository >> hasImageOnFileSystemNamed: aName [
	^ self baseDirectory / aName / (aName , '.image')
]

{ #category : 'initialization' }
PhLTestImageRepository >> initialize [

	super initialize.
	self setBaseDirectory: (FileSystem identifiableMemory: #ImageRepositoryStore) root.
	self createImageNamed: self singleImageName.
	

]

{ #category : 'initialization' }
PhLTestImageRepository >> singleImageName [
	^ 'TestImage'
	

]
