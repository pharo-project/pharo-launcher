Class {
	#name : 'PhLShowImageInFolderCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core-not-faulty',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'not-faulty'
}

{ #category : 'tests' }
PhLShowImageInFolderCommandTest >> testCommandShouldNotRaiseCommandErrorIfNoImageSelected [
	| command |
	presenter := PhLTestImagesPresenter new.
	presenter unselectAll.
	command := PhLShowImageInFolderCommand new.
	command context: presenter.

	self
		shouldnt: [ command execute ]
		raise: PhLCommandError
]
