"
Give me unit tests and I will make sure they are run for all subclasses of PhLAbstractTemplate
"
Class {
	#name : #PhLAbstractTemplateTest,
	#superclass : #ClassTestCase,
	#instVars : [
		'root'
	],
	#category : 'PharoLauncher-Tests-Core'
}

{ #category : #testing }
PhLAbstractTemplateTest class >> isAbstract [
	^ self name = #PhLAbstractTemplateTest
]

{ #category : #'instance-creation' }
PhLAbstractTemplateTest >> newTemplate [
	^ self subclassResponsibility
]

{ #category : #running }
PhLAbstractTemplateTest >> setUp [
	super setUp.
	root := FileSystem memory workingDirectory
]

{ #category : #tests }
PhLAbstractTemplateTest >> testHandleEOCDErrorWhenTemplateIsCorrupted [
	| template archive |
	template := self newTemplate.
	"simulate a broken zip archive)"
	archive := (ByteArray readHexFrom: ((1 to: 50) collect: [ :x| '0123456789ABCDEF' atRandom ])) readStream.

	self 
		should: [ template extractZipArchive: archive to: root ]
		raise: PhLCorruptedTemplateError 
]

{ #category : #tests }
PhLAbstractTemplateTest >> testNoEOCDErrorWhenTemplateIsOk [
	| template archive archiveFile |
	template := self newTemplate.
	self flag: 'TODO: I currently use concrete filesystem instead of memory fs because memory fs implementation is missing functionalities (should be solved in pharo 7.0)'.
	archiveFile := FileLocator temp / 'phl-abstract-template-test-no-eocd-error-arch.zip'.
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar'.

	archiveFile asFileReference binaryWriteStreamDo: [ :stream |
		archive writeTo: stream ].
	
	self 
		shouldnt: [ template extractZipArchive: archiveFile to: root ]
		raise: PhLCorruptedTemplateError
]

{ #category : #tests }
PhLAbstractTemplateTest >> testRelocateImageFilesFromToWithName [
	| template source destination imageName |
	template := self newTemplate.
	source := (root / 'old') ensureCreateDirectory.
	destination := (root / 'new') ensureCreateDirectory.
	(source / 'file.image') ensureCreateFile.
	(source / 'file.changes') ensureCreateFile.
	imageName := 'new'.
	self deny: (destination / imageName , 'image') exists.
	self deny: (destination / imageName , 'changes') exists.
	template relocateImageFilesFrom: source to: destination withName: imageName.
	self assert: (destination / imageName , 'image') exists.
	self assert: (destination / imageName , 'changes') exists
]
