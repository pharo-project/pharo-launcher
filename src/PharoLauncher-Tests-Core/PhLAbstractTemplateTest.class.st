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
