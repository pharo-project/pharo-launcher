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
		during: [ self runCommand: #('launcher' 'image' 'package' 'myImage' '/') ].
	
	script := imageFile parent / 'myImage.sh'.
	self assert: script isFile.
	self assert: (script readStream contents includesSubstring: '#!/usr/bin/env bash' ) 
]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreateZippedPackageShouldSucceed [
	
	 self imageRepository createImageNamed: 'myImage'.
	(self imageRepository baseDirectory / 'vms') ensureCreateDirectory. 
	(self imageRepository baseDirectory / 'vms' / 'aFakeVmToPutInThePackage') ensureCreateFile. 
	(self imageRepository baseDirectory / 'directoryWithResultingZip') ensureCreateDirectory. 
	
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ 
			self runCommand: #('launcher' 'image' 'package' 'myImage' '/directoryWithResultingZip' 'aFakeVmToPutInThePackage' '--zip').
					self assert: ((self imageRepository baseDirectory fileSystem / 'directoryWithResultingZip' / 'myImage.zip') isFile) ].
]
