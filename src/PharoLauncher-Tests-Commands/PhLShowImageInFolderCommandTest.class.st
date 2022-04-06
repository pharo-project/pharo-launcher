Class {
	#name : #PhLShowImageInFolderCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #tests }
PhLShowImageInFolderCommandTest >> testCommandRaisesCommandErrorIfNoImageSelected [
	| command |
	presenter := PhLTestImagesPresenter new.
	presenter unselectAll.
	command := PhLShowImageInFolderCommand new.
	command context: presenter.

	self
		should: [ command execute ]
		raise: PhLCommandError
]
