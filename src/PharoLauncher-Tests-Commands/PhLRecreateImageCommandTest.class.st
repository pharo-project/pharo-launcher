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

{ #category : #tests }
PhLRecreateImageCommandTest >> testCanRecreateAnImage [
	| command images archive zipFile image |
	command := PhLRecreateImageCommand new.
	command context: presenter.
	presenter selectImageAt: 1.
	images := presenter selectedImages.
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar.image'.
	archive addDeflateString: 'foo' as: 'bar.changes'.
	zipFile := presenter fileSystem / 'template.zip'. 
	zipFile binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	images do: [ :img | img originTemplate: (PhLLocalTemplate name: 'Foo test template' zipFile: zipFile)].
	presenter selection: images.
	
	command execute.
	
	images := command imagesPresenter imageNames.
	self
		assertCollection: images
		hasSameElements: #('TestImage').
	image := presenter fileSystem / 'TestImage' /'TestImage.image'.
	self assert: image exists.
	self assert: image contents equals: 'foo'.
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

{ #category : #tests }
PhLRecreateImageCommandTest >> testRecreateAnImageShouldCarryOverTheScript [
	| command images archive zipFile image newImage |
	command := PhLRecreateImageCommand new.
	command context: presenter.
	presenter selectImageAt: 1.
	images := presenter selectedImages.
   image := images first.
   image initializationScript: (FileSystem memory root / 'foo.st') asFileReference.
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar.image'.
	archive addDeflateString: 'foo' as: 'bar.changes'.
	zipFile := presenter fileSystem / 'template.zip'. 
	zipFile binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	images do: [ :img | img originTemplate: (PhLLocalTemplate name: 'Foo test template' zipFile: zipFile)].
	presenter selection: images.
	
	command execute.
	
	presenter selectImageAt: 1.
	newImage := presenter selectedImages first.
	self assert: image initializationScript equals: newImage initializationScript 
]

{ #category : #tests }
PhLRecreateImageCommandTest >> testRecreateAnImageShouldResetShouldRunInitializationScriptFlag [
	| command images archive zipFile image |
	command := PhLRecreateImageCommand new.
	command context: presenter.
	presenter selectImageAt: 1.
	images := presenter selectedImages.
   image := images first.
   image initializationScript: (FileSystem memory root / 'foo.st') asFileReference.
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar.image'.
	archive addDeflateString: 'foo' as: 'bar.changes'.
	zipFile := presenter fileSystem / 'template.zip'. 
	zipFile binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	images do: [ :img | img originTemplate: (PhLLocalTemplate name: 'Foo test template' zipFile: zipFile)].
	presenter selection: images.
	
	self assert: image shouldRunInitializationScript.
	
	command execute.
	
	presenter selectImageAt: 1.
	images := presenter selectedImages.
   image := images first.
	self assert: image shouldRunInitializationScript.

]

{ #category : #tests }
PhLRecreateImageCommandTest >> testRecreateAnImageWithoutOpeningItShouldStillExecuteScript [
	| command images archive zipFile image |
	command := PhLRecreateImageCommand new.
	command context: presenter.
	presenter selectImageAt: 1.
	images := presenter selectedImages.
   image := images first.
   image initializationScript: (FileSystem memory root / 'foo.st') asFileReference.
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar.image'.
	archive addDeflateString: 'foo' as: 'bar.changes'.
	zipFile := presenter fileSystem / 'template.zip'. 
	zipFile binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	images do: [ :img | img originTemplate: (PhLLocalTemplate name: 'Foo test template' zipFile: zipFile)].
	presenter selection: images.
	
   image shouldRunInitializationScript: false.
	self deny: image shouldRunInitializationScript.
	
	command execute.
	
	presenter selectImageAt: 1.
	images := presenter selectedImages.
   image := images first.
	self assert: image shouldRunInitializationScript.

]
