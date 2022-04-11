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

	super setUp.
	"set to laucher model necessary image mock repository"
	context launcherModel imageRepository: PhLImagesMockRepo new.

]

{ #category : #accessing }
PhLImageCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]
