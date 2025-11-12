"
Give me unit tests and I will make sure they are run for all subclasses of PhLAbstractTemplate
"
Class {
	#name : 'PhLAbstractTemplateTest',
	#superclass : 'ClassTestCase',
	#instVars : [
		'root'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'testing' }
PhLAbstractTemplateTest class >> isAbstract [
	^ self name = #PhLAbstractTemplateTest
]

{ #category : 'instance creation' }
PhLAbstractTemplateTest >> newTemplate [
	^ self subclassResponsibility
]

{ #category : 'running' }
PhLAbstractTemplateTest >> setUp [
	super setUp.
	root := FileSystem memory workingDirectory
]

{ #category : 'tests' }
PhLAbstractTemplateTest >> testCanRelocateImageFileWhenNotInZipArchiveRoot [
	| template folder imageToBeRenamed changesFileToBeRenamed someOtherFile targetDirectory imageName |
	template := self newTemplate.
	folder := (root / 'level1' / 'level2' / 'imageFolder') ensureCreateDirectory.
	imageToBeRenamed := (folder / 'file.image') ensureCreateFile.
	changesFileToBeRenamed := (folder / 'file.changes') ensureCreateFile.
	someOtherFile := (folder / 'foo.css') ensureCreateFile.
	imageName := 'foo'.
	targetDirectory := root / imageName.

	template relocateImageFilesFrom: folder to: targetDirectory.

	self assert: (targetDirectory / imageName , 'image') exists.
	self deny: imageToBeRenamed exists.
	self assert: (targetDirectory / imageName , 'changes') exists.
	self deny: changesFileToBeRenamed exists.
	self assert: (targetDirectory / someOtherFile basename) exists
]

{ #category : 'tests' }
PhLAbstractTemplateTest >> testHandleEOCDErrorWhenTemplateIsCorrupted [
	| template archive |
	
	self skip: 'need to handle modal presenter to run this test (progress)'.
	
	template := self newTemplate.
	"simulate a broken zip archive)"
	archive := (ByteArray readHexFrom: ((1 to: 50) collect: [ :x| '0123456789ABCDEF' atRandom ])) readStream.

	self 
		should: [ template extractZipArchive: archive into: root ]
		raise: PhLCorruptedTemplateError 
]

{ #category : 'tests' }
PhLAbstractTemplateTest >> testNoEOCDErrorWhenTemplateIsOk [
	| template archive archiveFile |
	template := self newTemplate.
	archiveFile := root / 'phl-abstract-template-test-no-eocd-error-arch.zip'.
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar'.

	archiveFile asFileReference binaryWriteStreamDo: [ :stream |
		archive writeTo: stream ].
	
	self 
		shouldnt: [ template extractZipArchive: archiveFile into: root ]
		raise: PhLCorruptedTemplateError
]

{ #category : 'tests' }
PhLAbstractTemplateTest >> testRenameImageFilesFromToWithName [
	| template folder imageToBeRenamed changesFileToBeRenamed someOtherFile targetDirectory imageName |
	template := self newTemplate.
	folder := (root / 'imageFolder') ensureCreateDirectory.
	imageToBeRenamed := (folder / 'file.image') ensureCreateFile.
	changesFileToBeRenamed := (folder / 'file.changes') ensureCreateFile.
	someOtherFile := (folder / 'foo.css') ensureCreateFile.
	imageName := 'foo'.
	targetDirectory := root / imageName.

	template relocateImageFilesFrom: folder to: targetDirectory.

	self assert: (targetDirectory / imageName , 'image') exists.
	self deny: imageToBeRenamed exists.
	self assert: (targetDirectory / imageName , 'changes') exists.
	self deny: changesFileToBeRenamed exists.
	self assert: (targetDirectory / someOtherFile basename) exists
]
