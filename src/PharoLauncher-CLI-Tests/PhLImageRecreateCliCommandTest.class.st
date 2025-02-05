Class {
	#name : 'PhLImageRecreateCliCommandTest',
	#superclass : 'PhLImageCliCommandTest',
	#category : 'PharoLauncher-CLI-Tests-Commands',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Commands'
}

{ #category : 'running' }
PhLImageRecreateCliCommandTest >> setUp [
	super setUp.
	self launcherModel templateRepository: PhLTemplateTestRepository new.
	self launcherModel imageRepository: PhLTestImageRepository new.

]

{ #category : 'tests' }
PhLImageRecreateCliCommandTest >> testCanRecreateAnImageShouldSucceed [
	| image imageFile |
	imageFile := self imageRepository createImageNamed: 'myImage'.
	image := PhLImage location: imageFile.
	image originTemplate: (self templateRepository createLocalTemplateNamed: 'Foo test template').
		
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [
			self deny: imageFile binaryReadStream contents equals: self testTemplateContent.
			self runCommand: #('launcher' 'image' 'recreate' 'myImage').
			self assertSuccess.
			self assert: imageFile exists.
			self assert: imageFile binaryReadStream contents equals: self testTemplateContent ].

]

{ #category : 'tests' }
PhLImageRecreateCliCommandTest >> testCanRecreateAnImageWhenNoImageNameProvidedByInteractiveImageSelection [
	| image imageFile |
	imageFile := self imageRepository createImageNamed: 'myImage'.
	image := PhLImage location: imageFile.
	image originTemplate: (self templateRepository createLocalTemplateNamed: 'Foo test template').
	self addInputAnswer: '1'.
		
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [
			self deny: imageFile binaryReadStream contents equals: self testTemplateContent.
			
			self runCommand: #('launcher' 'image' 'recreate').
			
			self assertSuccess.
			self assert: imageFile exists.
			self assert: imageFile binaryReadStream contents equals: self testTemplateContent].

]

{ #category : 'accessing' }
PhLImageRecreateCliCommandTest >> testTemplateContent [

	^ #[102 111 111] " 'foo' in binary) "
]
