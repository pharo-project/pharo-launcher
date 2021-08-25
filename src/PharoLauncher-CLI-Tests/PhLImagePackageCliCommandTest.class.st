Class {
	#name : #PhLImagePackageCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#instVars : [
		'vmStoreBackup',
		'vmName'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #running }
PhLImagePackageCliCommandTest >> setUp [
	| tempVmStoreFolder |
	super setUp.
	self launcherModel templateRepository: PhLTemplateTestRepository new.
	self launcherModel imageRepository: PhLTestImageRepository new.

	vmStoreBackup := PhLVirtualMachineManager vmStore.
	tempVmStoreFolder := self imageRepository baseDirectory fileSystem root / 'vms'.
	PhLVirtualMachineManager vmStore: tempVmStoreFolder.
	vmName := 'aFakeVmToPutInThePackage'.
	(PhLVirtualMachineManager vmStore / vmName) ensureCreateDirectory.
	(PhLVirtualMachineManager vmStore / vmName / 'pharo') ensureCreateFile.

]

{ #category : #running }
PhLImagePackageCliCommandTest >> tearDown [
	PhLVirtualMachineManager vmStore: vmStoreBackup.
	super tearDown
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
PhLImagePackageCliCommandTest >> testCreatePackageShouldSucceed [
	| packaged  |
	self imageRepository createImageNamed: 'myImage'.
	packaged := (self imageRepository baseDirectory / 'directoryWithResultingPackage') ensureCreateDirectory.
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ 
			self runCommand: {'launcher' . 'image' . 'package' . 'myImage' . packaged basename . '--vm' . vmName}.
			
			self assert: (packaged / 'myImage' / 'myImage.image') isFile ]
]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreatePackageWhenNoLocationSetShouldReturnError [
	self imageRepository createImageNamed: 'myImage'.
	(self imageRepository baseDirectory / 'directoryWithResultingPackage' / 'myImage') ensureCreateDirectory. 
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ 
			self runCommand: {'launcher' . 'image' . 'package' . 'myImage' . '--vm' . vmName}.
			
			self assert: (self errorString includesSubstring: 'no path to put the package') ].
]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreatePackageWhenOutputFolderExistsShouldReturnError [
	| outputFolder |
	self imageRepository createImageNamed: 'myImage'.
	outputFolder := (self imageRepository baseDirectory / 'directoryWithResultingPackage') ensureCreateDirectory. 
	(outputFolder / 'myImage') ensureCreateDirectory. 
	
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ 
			self runCommand: {'launcher' . 'image' . 'package' . 'myImage' . outputFolder basename . '--vm' . vmName}.
			
			self assert: (self errorString includesSubstring: 'a Directory with the image name already exists') ].
]

{ #category : #tests }
PhLImagePackageCliCommandTest >> testCreateZippedPackageShouldSucceed [
	| packaged |
	self imageRepository createImageNamed: 'myImage'.
	(self imageRepository baseDirectory / 'directoryWithResultingPackage') ensureCreateDirectory.
		
	DiskStore
		currentFileSystem: self imageRepository baseDirectory fileSystem
		during: [ | outputZip |
			outputZip := '/directoryWithResultingZip'. 
			self runCommand: {'launcher' . 'image' . 'package' . 'myImage' . outputZip . '--vm' . vmName . '--zip'}.
			
			packaged := self imageRepository baseDirectory fileSystem / outputZip.
			self assert: (packaged / 'myImage.zip') isFile ].
]
