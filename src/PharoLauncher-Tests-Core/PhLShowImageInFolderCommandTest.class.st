Class {
	#name : 'PhLShowImageInFolderCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core-Move-From-Commands',
	#package : 'PharoLauncher-Tests-Core',
	#tag : 'Move-From-Commands'
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
