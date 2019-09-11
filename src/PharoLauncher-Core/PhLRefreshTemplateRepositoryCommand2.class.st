"
Ask the template repository to update.
"
Class {
	#name : #PhLRefreshTemplateRepositoryCommand2,
	#superclass : #PhLGeneralCommand2,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLRefreshTemplateRepositoryCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallUpdateIcon;
		shortcutKey: $u meta;
		yourself
]

{ #category : #executing }
PhLRefreshTemplateRepositoryCommand2 >> execute [
	self context templateRepository refresh
]

{ #category : #initialization }
PhLRefreshTemplateRepositoryCommand2 >> initialize [ 
	super initialize.
	self
		basicName: 'Refresh';
		basicDescription: 'Refresh template list'.
]
