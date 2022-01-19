"
Command to inspect the current selection
"
Class {
	#name : #PhLInspectCommand,
	#superclass : #PhLImageCommand,
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLInspectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallInspectIt;
		shortcutKey: $i meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #accessing }
PhLInspectCommand >> canBeExecuted [
	^ self imagesPresenter selectedImages isNotEmpty
]

{ #category : #executing }
PhLInspectCommand >> execute [
	self imagesPresenter singleImage inspect
]

{ #category : #initialization }
PhLInspectCommand >> initialize [
	super initialize.
	self
		name: 'Inspect';
		description: 'Inspect the selected element'
]
