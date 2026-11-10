"
I check the patch of SpMorphicBackend>>#executeOpenFileDialog: (see PhLPatchNewToolsIssue1552).
"
Class {
	#name : 'PhLMorphicOpenFileDialogTest',
	#superclass : 'TestCase',
	#instVars : [
		'backend'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'running' }
PhLMorphicOpenFileDialogTest >> setUp [

	super setUp.
	backend := PhLTestFileDialogMorphicBackend new
]

{ #category : 'tests' }
PhLMorphicOpenFileDialogTest >> testCancelledDialogAnswersNil [

	backend dialogResult: nil.

	self assert: (backend executeOpenFileDialog: SpFileDialog new) isNil
]

{ #category : 'tests' }
PhLMorphicOpenFileDialogTest >> testChosenFileIsAnswered [

	| file |
	file := FileSystem memory / 'foo.image'.
	backend dialogResult: { file }.

	self assert: (backend executeOpenFileDialog: SpFileDialog new) equals: file
]
