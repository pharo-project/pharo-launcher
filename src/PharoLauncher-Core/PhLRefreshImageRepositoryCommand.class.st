"
Ask the image repository to update.
"
Class {
	#name : #PhLRefreshImageRepositoryCommand,
	#superclass : #PhLGeneralCommand,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLRefreshImageRepositoryCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdateIcon;
		shortcutKey: $u meta;
		yourself
]

{ #category : #executing }
PhLRefreshImageRepositoryCommand >> execute [
	self context imageRepository contentsChanged.
]

{ #category : #initialization }
PhLRefreshImageRepositoryCommand >> initialize [
	super initialize.
	self
		name: 'Refresh';
		description: 'Refresh image list'
]
