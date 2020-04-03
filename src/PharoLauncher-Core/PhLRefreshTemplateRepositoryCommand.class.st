"
Ask the template repository to update.
"
Class {
	#name : #PhLRefreshTemplateRepositoryCommand,
	#superclass : #PhLGeneralCommand,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLRefreshTemplateRepositoryCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdateIcon;
		shortcutKey: $u meta;
		yourself
]

{ #category : #executing }
PhLRefreshTemplateRepositoryCommand >> execute [
	self context templateRepository refresh
]

{ #category : #initialization }
PhLRefreshTemplateRepositoryCommand >> initialize [ 
	super initialize.
	self
		basicName: 'Refresh';
		basicDescription: 'Refresh template list'.
]
