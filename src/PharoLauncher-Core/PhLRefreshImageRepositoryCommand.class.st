"
Ask the image repository to update.
"
Class {
	#name : 'PhLRefreshImageRepositoryCommand',
	#superclass : 'PhLGeneralCommand',
	#classVars : [
		'LauncherVersion'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLRefreshImageRepositoryCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdate;
		shortcutKey: $u actionModifier;
		yourself
]

{ #category : 'executing' }
PhLRefreshImageRepositoryCommand >> execute [

	self context imageRepository contentsChanged
]

{ #category : 'initialization' }
PhLRefreshImageRepositoryCommand >> initialize [
	super initialize.
	self
		name: 'Refresh';
		description: 'Refresh image list'
]
