Class {
	#name : #PhLShowImageInFolderCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #tests }
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
