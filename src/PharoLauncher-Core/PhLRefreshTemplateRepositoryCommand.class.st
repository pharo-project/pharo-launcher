"
Ask the template repository to update.
"
Class {
	#name : #PhLRefreshTemplateRepositoryCommand,
	#superclass : #PhLGeneralCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLRefreshTemplateRepositoryCommand class >> group [
	^ 3
]

{ #category : #accessing }
PhLRefreshTemplateRepositoryCommand class >> icon [
	^ self iconNamed: #smallUpdateIcon
]

{ #category : #accessing }
PhLRefreshTemplateRepositoryCommand class >> title [
	^ 'Refresh template list'
]

{ #category : #action }
PhLRefreshTemplateRepositoryCommand >> execute [
	self model templateRepository refresh
]
