Class {
	#name : #PhLImagesPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #running }
PhLImagesPresenterTest >> tearDown [ 
	presenter window ifNotNil: #close
]

{ #category : #tests }
PhLImagesPresenterTest >> testImagesPresenterIsRefreshedWhenApplicationNotifyImageRepositoryChanged [
	presenter := PhLTestImagesPresenter new. 
	presenter openWithSpec.
	
	presenter createImageNamed: 'Foo'.
	presenter application imageRepositoryChanged.
	
	self
		assertCollection: presenter imageNames
		hasSameElements: #('TestImage' 'Foo').
]
