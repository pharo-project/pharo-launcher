"
Ask the image repository to update.
"
Class {
	#name : #PhLRefreshImageRepositoryCommand2,
	#superclass : #PhLGeneralCommand2,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRefreshImageRepositoryCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdateIcon;
		shortcutKey: $q meta;
		yourself
]

{ #category : #executing }
PhLRefreshImageRepositoryCommand2 >> execute [
	self context imageRepository contentsChanged.
]

{ #category : #initialization }
PhLRefreshImageRepositoryCommand2 >> initialize [ 
	super initialize.
	self
		basicName: 'Refresh';
		basicDescription: 'Refresh image list'.
]
