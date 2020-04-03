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
	| imagesDirectory app repository |
	super setUp.
	fs := FileSystem memory.
	imagesDirectory := (fs root / 'images') ensureCreateDirectory.
	repository := PhLDirectoryBasedImageRepository forDirectory: imagesDirectory.
	app := PharoLauncherApplication new
		imageRepository: repository;
		yourself.
	imagesPresenter := PhLImagesPresenter newApplication: app model: repository
]

{ #category : #running }
PhLOpenNewImageWindowTest >> tearDown [
	presenter ifNotNil: [ presenter window close ].
	super tearDown
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
