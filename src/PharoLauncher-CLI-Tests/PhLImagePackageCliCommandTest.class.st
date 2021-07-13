Class {
	#name : #PhLImagePackageCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #running }
PhLImagePackageCliCommandTest >> setUp [
	super setUp.
	self launcherModel templateRepository: PhLTemplateTestRepository new.
	self launcherModel imageRepository: PhLTestImageRepository new.

]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreateLaunchScriptShouldSucceed [
	| imageFile script |
	imageFile := self imageRepository createImageNamed: 'myImage'.
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ self runCommand: #('launcher' 'image' 'package' 'myImage') ].
	
	script := imageFile parent / 'myImage.sh'.
	self assert: script isFile.
	self assert: (script readStream contents includesSubstring: 'pharo-launcher image launch ' , imageFile fullName) 
]
