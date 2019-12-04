Class {
	#name : #PhLOpenNewImageWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLOpenNewImageWindowTest >> tearDown [ 
	presenter ifNotNil: [ presenter window close ]
]

{ #category : #tests }
PhLOpenNewImageWindowTest >> testOfficialTemplatesCategoryIsSelectedWhenOpeningPresenter [
	presenter := PhLOpenNewImageWindowCommand new 
		context: PhLImagesPresenter basicNew;
		execute.

	self 
		assert: presenter selectedTemplateCategory name
		equals: 'Official distributions'
]

{ #category : #tests }
PhLOpenNewImageWindowTest >> testTemplatesPresenterOpenWhenClickingOnNewImage [
	presenter := PhLOpenNewImageWindowCommand new 
		context: PhLImagesPresenter basicNew;
		execute.

	self 
		assert: presenter className
		equals: #PhLTemplatesPresenter.
]
