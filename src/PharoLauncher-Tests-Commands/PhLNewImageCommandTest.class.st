Class {
	#name : #PhLNewImageCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLNewImageCommandTest >> tearDown [ 
	presenter ifNotNil: [ presenter window close ]
]

{ #category : #tests }
PhLNewImageCommandTest >> testOfficialTemplatesCategoryIsSelectedWhenOpeningPresenter [
	presenter := PhLNewImageCommand new 
		context: PhLImagesPresenter basicNew;
		execute.

	self 
		assert: presenter selectedTemplateCategory name
		equals: 'Official distributions'
]

{ #category : #tests }
PhLNewImageCommandTest >> testTemplatesPresenterOpenWhenClickingOnNewImage [
	presenter := PhLNewImageCommand new 
		context: PhLImagesPresenter basicNew;
		execute.

	self 
		assert: presenter className
		equals: #PhLTemplatesPresenter.
]
