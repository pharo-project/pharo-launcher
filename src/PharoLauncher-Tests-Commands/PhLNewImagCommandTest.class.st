Class {
	#name : #PhLNewImagCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLNewImagCommandTest >> tearDown [ 
	presenter ifNotNil: [ presenter window close ]
]

{ #category : #tests }
PhLNewImagCommandTest >> testTemplatesPresenterOpenWhenClickingOnNewImage [
	presenter := PhLNewImageCommand new 
		context: PhLImagesPresenter basicNew;
		execute.

	self 
		assert: presenter className
		equals: #PhLTemplatesPresenter.
]
