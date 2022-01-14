Class {
	#name : #PhLImageCliCommandTest,
	#superclass : #PhLCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #adding }
PhLImageCliCommandTest >> addImageNamed: anImageName [
	^ self imageRepository addImageNamed: anImageName
]

{ #category : #accessing }
PhLImageCliCommandTest >> imageRepository [ 
	^ self launcherModel imageRepository
]

{ #category : #running }
PhLImageCliCommandTest >> setUp [
	| model |
	super setUp.
	model := PharoLauncherCLIModel new.
	model imageRepository: PhLImagesMockRepo tenRandomImages.
	context := PhLCliClapContext specification: PhLCliCommand launcherCommand.
	context launcherModel: model
]

{ #category : #accessing }
PhLImageCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]
