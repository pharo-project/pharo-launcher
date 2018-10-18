"
Ask the image repository to update.
"
Class {
	#name : #PhLRefreshImageRepositoryCommand,
	#superclass : #PhLGeneralCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLRefreshImageRepositoryCommand class >> group [
	^ 3
]

{ #category : #accessing }
PhLRefreshImageRepositoryCommand class >> icon [
	^ self iconNamed: #smallUpdateIcon
]

{ #category : #accessing }
PhLRefreshImageRepositoryCommand class >> title [
	^ 'Refresh image list'
]

{ #category : #action }
PhLRefreshImageRepositoryCommand >> execute [
	self model imageRepository contentsChanged.

]
