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
PhLImagePackageCliCommandTest >> testCreatePackageAlreadyCreateShouldReturnError [
	 self imageRepository createImageNamed: 'myImage'.
	(self imageRepository baseDirectory / 'vms') ensureCreateDirectory. 
	(self imageRepository baseDirectory / 'vms' / 'aFakeVmToPutInThePackage') ensureCreateFile. 
	(self imageRepository baseDirectory / 'directoryWithResultingPackage') ensureCreateDirectory. 
	(self imageRepository baseDirectory / 'directoryWithResultingPackage' / 'myImage') ensureCreateDirectory. 
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ 
			self runCommand: #('launcher' 'image' 'package' 'myImage' '/directoryWithResultingPackage' '--vm' 'aFakeVmToPutInThePackage').
			self assert: (self errorString includesSubstring: 'a Directory with the image name already exists') ].
]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreatePackageNoLocationSettedShouldReturnError [
	 self imageRepository createImageNamed: 'myImage'.
	(self imageRepository baseDirectory / 'vms') ensureCreateDirectory. 
	(self imageRepository baseDirectory / 'vms' / 'aFakeVmToPutInThePackage') ensureCreateFile. 
	(self imageRepository baseDirectory / 'directoryWithResultingPackage') ensureCreateDirectory. 
	(self imageRepository baseDirectory / 'directoryWithResultingPackage' / 'myImage') ensureCreateDirectory. 
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ 
			self runCommand: #('launcher' 'image' 'package' 'myImage' '--vm' 'aFakeVmToPutInThePackage').
			self assert: (self errorString includesSubstring: 'no path to put the package') ].
]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreatePackageShouldSucceed [
	self imageRepository createImageNamed: 'myImage'.
	(self imageRepository baseDirectory / 'vms') ensureCreateDirectory.
	(self imageRepository baseDirectory / 'vms'
		/ 'aFakeVmToPutInThePackage') ensureCreateFile.
	(self imageRepository baseDirectory / 'directoryWithResultingPackage')
		ensureCreateDirectory.
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ self
				runCommand:
					#('launcher' 'image' 'package' 'myImage' '/directoryWithResultingPackage' '--vm' 'aFakeVmToPutInThePackage').
			self
				assert:
					(self imageRepository baseDirectory fileSystem
						/ 'directoryWithResultingPackage' / 'myImage' / 'myImage.image')
						isFile ]
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
			self runCommand: #('launcher' 'image' 'package' 'myImage' '/directoryWithResultingZip' '--vm' 'aFakeVmToPutInThePackage' '--zip').
					self assert: ((self imageRepository baseDirectory fileSystem / 'directoryWithResultingZip' / 'myImage.zip') isFile) ].
]
