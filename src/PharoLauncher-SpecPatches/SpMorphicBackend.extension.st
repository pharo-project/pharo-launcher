Extension { #name : 'SpMorphicBackend' }

{ #category : '*PharoLauncher-SpecPatches-NewToolsOpenFileDialog' }
SpMorphicBackend >> executeOpenFileDialog: aFileDialog [

	| entries |
	entries := (self newFileDialogFor: aFileDialog) openModal.
	entries isEmptyOrNil ifTrue: [ ^ nil ].
	^ entries first asFileReference
]
