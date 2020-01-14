Class {
	#name : #PhLOpenNewImageWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'imagesPresenter',
		'fs'
	],
	#category : #'PharoLauncher-Tests-Commands'
}

{ #category : #running }
PhLOpenNewImageWindowTest >> setUp [
	| imagesDirectory app |
	fs := FileSystem memory.
	imagesDirectory := (fs root / 'images') ensureCreateDirectory.
	app := PharoLauncherApplication new 
		imageRepository: imagesDirectory;
		yourself.
	imagesPresenter := PhLImagesPresenter 
		newApplication: app 
		model: (PhLDirectoryBasedImageRepository forDirectory: imagesDirectory).
]

{ #category : #running }
PhLOpenNewImageWindowTest >> tearDown [ 
	presenter ifNotNil: [ presenter window close ]
]

{ #category : #tests }
PhLOpenNewImageWindowTest >> testOfficialTemplatesCategoryIsSelectedWhenOpeningPresenter [
	presenter := PhLOpenNewImageWindowCommand new 
		context: imagesPresenter;
		execute.

	self 
		assert: presenter selectedTemplateCategory name
		equals: 'Official distributions'
]

{ #category : #tests }
PhLOpenNewImageWindowTest >> testTemplatesPresenterOpenWhenClickingOnNewImage [
	presenter := PhLOpenNewImageWindowCommand new 
		context: imagesPresenter;
		execute.

	self 
		assert: presenter className
		equals: #PhLTemplatesPresenter.
]
