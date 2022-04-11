Class {
	#name : #PhLRecreateImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLRecreateImageCommandTest >> setUp [
	super setUp.
	presenter := PhLTestImagesPresenter new
]

{ #category : #acccessing }
PhLRecreateImageCommandTest >> templateZipFile [
	| archive zipFile |
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar.image'.
	archive addDeflateString: 'foo' as: 'bar.changes'.
	
	zipFile := FileSystem memory root / 'template.zip'.
	zipFile binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	^ zipFile
]

{ #category : #tests }
PhLRecreateImageCommandTest >> testCanRecreateAnImage [
	| command images image |
	command := PhLRecreateImageCommand new.
	command context: presenter.
	presenter selectImageAt: 1.
	images := presenter selectedImages.
	images
		do: [ :img | 
			img originTemplate: (PhLLocalTemplate name: 'Foo test template' zipFile: self templateZipFile) ].
	presenter selection: images.
	
	command execute.
	
	images := command imagesPresenter imageNames.
	self assertCollection: images hasSameElements: #('TestImage').
	image := presenter imageRepository hasImageOnFileSystemNamed: 'TestImage'.
	self assert: image exists.
	self assert: image contents equals: 'foo'
]

{ #category : #tests }
PhLRecreateImageCommandTest >> testErrorRaiseWhenImageTemplateNotSet [
	| command |
	command := PhLRecreateImageCommand new.
	command context: presenter.
	presenter selectImageAt: 1.
	
	self
		should: [ command execute ]
		raise: PhLError 
	
	
]
