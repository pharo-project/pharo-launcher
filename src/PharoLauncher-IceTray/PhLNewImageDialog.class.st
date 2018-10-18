Class {
	#name : #PhLNewImageDialog,
	#superclass : #ITBasicPresenter,
	#instVars : [
		'catalogTable',
		'propertyPanel'
	],
	#category : 'PharoLauncher-IceTray'
}

{ #category : #specs }
PhLNewImageDialog class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed
		newColumn: [ :column | 
			column add: #catalogTable.
			column addSplitter.
"			column add: #propertyPanel" ];
		yourself.
		
]

{ #category : #accessing }
PhLNewImageDialog >> catalogTable [
	^ catalogTable
]

{ #category : #accessing }
PhLNewImageDialog >> catalogTable: anObject [
	catalogTable := anObject
]

{ #category : #initializing }
PhLNewImageDialog >> context [
	^ PharoLauncherModel
		selection: nil 
		imageRepository: PhLDirectoryBasedImageRepository default
		templateRepository: PhLTemplateGroupRepository forSelectedGroups
]

{ #category : #initializing }
PhLNewImageDialog >> firstlySelectedImage [
	^ nil
]

{ #category : #initializing }
PhLNewImageDialog >> initializeBody [

	(catalogTable := self newTitledTree)
		title: 'New Image Templates' translated;
		doubleClickCommandClass: PhLCreateImageFromTemplateCommand.
		
		
		
	catalogTable

		context: self context;
		repository: PhLTemplateGroupRepository forSelectedGroups.
	propertyPanel := self instantiate: PhLImagePresenter on: nil
]

{ #category : #accessing }
PhLNewImageDialog >> initializeToolbar [
	self toolbar
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallNewIcon);
				help: 'Create new image';
				action: [ self createNewImage ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				icon: (self iconNamed: #smallLoadProject);
				help: 'Import image';
				action: [ self spawnImportImageDialog ];
				yourself)
			position: ITItemPosition left
]

{ #category : #accessing }
PhLNewImageDialog >> initializeWidgets [
	self initializeToolbar. 
	self initializeBody.
]

{ #category : #initializing }
PhLNewImageDialog >> newTitledTree [ 
	^ self instantiate: PhLTitledTreePresenter.
]

{ #category : #accessing }
PhLNewImageDialog >> propertyPanel [
	^ propertyPanel
]

{ #category : #accessing }
PhLNewImageDialog >> propertyPanel: anObject [
	propertyPanel := anObject
]

{ #category : #accessing }
PhLNewImageDialog >> spawnImportImageDialog [
	PhLImportImageCommand new execute
]
