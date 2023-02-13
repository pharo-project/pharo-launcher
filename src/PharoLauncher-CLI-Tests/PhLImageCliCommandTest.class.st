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
	self useMockImagesRepository
]

{ #category : #accessing }
PhLImageCliCommandTest >> templateRepository [ 
	^ self launcherModel templateRepository
]

{ #category : #running }
PhLImageCliCommandTest >> useMockImagesRepository [

	context launcherModel imageRepository: PhLImagesMockRepo new
]
