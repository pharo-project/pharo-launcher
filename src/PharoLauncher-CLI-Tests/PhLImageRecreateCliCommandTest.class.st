Class {
	#name : #PhLImageRecreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #running }
PhLImageRecreateCliCommandTest >> setUp [
	super setUp.
	self launcherModel templateRepository: PhLTemplateTestRepository new.
	self launcherModel imageRepository: PhLTestImageRepository new.

]

{ #category : #tests }
PhLImageRecreateCliCommandTest >> testCanRecreateAnImageShouldSucceed [
	| image imageFile |
	imageFile := self imageRepository createImageNamed: 'myImage'.
	image := PhLImage location: imageFile.
	image originTemplate: (self templateRepository createLocalTemplateNamed: 'Foo test template').
		
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [
			self deny: imageFile contents equals: 'foo'.
			self runCommand: #('launcher' 'image' 'recreate' 'myImage').
			
			self assert: imageFile exists.
			self assert: imageFile contents equals: 'foo'].

]
