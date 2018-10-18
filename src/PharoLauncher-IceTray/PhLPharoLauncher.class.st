Class {
	#name : #PhLPharoLauncher,
	#superclass : #ITBasicPresenter,
	#instVars : [
		'imagesTable',
		'propertyPanel',
		'statusBar'
	],
	#category : 'PharoLauncher-IceTray'
}

{ #category : #specs }
PhLPharoLauncher class >> defaultSpec [
	<spec: #default>

	^ SpecLayout composed
		newColumn: [ :column | 
			column add: #imagesTable.
			column addSplitter.
			column add: #propertyPanel ];
		yourself.
		
]

{ #category : #specs }
PhLPharoLauncher class >> showTime [
	<example>
	^ self new openWithSpec
]

{ #category : #specs }
PhLPharoLauncher class >> title [
	^ 'Pharo Launcher'
]

{ #category : #accessing }
PhLPharoLauncher >> context [
	^ PharoLauncherModel
		selection: imagesTable morph selectedItems
		imageRepository: PhLDirectoryBasedImageRepository default
		templateRepository: PhLTemplateGroupRepository forSelectedGroups
]

{ #category : #actions }
PhLPharoLauncher >> copySelectedImage [
	PhLCopyImageCommand new
		setModel: self context;
		execute
]

{ #category : #actions }
PhLPharoLauncher >> deleteSelectedImage [
	PhLDeleteImageCommand new
		setModel: self context;
		execute.
	self refresh
]

{ #category : #actions }
PhLPharoLauncher >> firstlySelectedImage [

	^ imagesTable morph selectedItems size = 1 
		ifTrue: [ imagesTable morph selectedItems anyOne ]
		ifFalse: [ nil ]
]

{ #category : #'as yet unclassified' }
PhLPharoLauncher >> images: aCollection [
	imagesTable morph elements: aCollection.
	imagesTable morph selectRowIndex: 0.

]

{ #category : #accessing }
PhLPharoLauncher >> imagesTable [
	^ imagesTable
]

{ #category : #accessing }
PhLPharoLauncher >> imagesTable: aTable [
	imagesTable := aTable
]

{ #category : #initialization }
PhLPharoLauncher >> initializeBody [
	imagesTable := self newFTSmartTable.
	self initializeImageTable: imagesTable morph.
	propertyPanel := self instantiate: PhLImagePresenter on: self firstlySelectedImage.
	self refresh
]

{ #category : #initialization }
PhLPharoLauncher >> initializeImageTable: aTableMorph [
	aTableMorph
		add: #name
			menu: [ :menu :target | 
			menu
				add: #Launch target: self selector: #launchSelectedImageWithSettings;
				add: #'Launch without settings' target: self selector: #launchSelectedImageWithSettings;
				add: #'Copy selected image' target: self selector: #copySelectedImage ]
			width: 300;
		add: #vm width: 50;
		add: #template width: 300;
		add: #'last modification' accessing: #lastModification width: 100;
		onAnnouncement: FTSelectionChanged do: [ :ann | self selectionChanged: ann];
		onAnnouncement: FTStrongSelectionChanged do: [ :ann | self launchSelectedImageWithSettings ].
	aTableMorph showRowIndex width: 50
]

{ #category : #initialization }
PhLPharoLauncher >> initializeStatusbar. [
 " Nothing yet "
]

{ #category : #initialization }
PhLPharoLauncher >> initializeToolbar [
	self toolbar
		addItem:
			(ITButton new
				label: 'New';
				icon: (self iconNamed: #smallNewIcon);
				help: 'Create new image';
				action: [ self spawnNewImageDialog ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'Launch';
				icon: (self iconNamed: #smallDoItIcon);
				help: 'Launch image with settings';
				action: [ self launchSelectedImageWithSettings ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'Basic launch';
				icon: (self iconNamed: #smallDoItIcon) asGrayScaleWithAlpha;
				help: 'Launch image without settings';
				action: [ self launchSelectedImageWithoutSettings ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'Import';
				icon: (self iconNamed: #smallLoadProject);
				help: 'Import image';
				action: [ self spawnImportImageDialog ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'Delete';
				icon: (self iconNamed: #smallDelete);
				help: 'Delete selected image';
				action: [ self deleteSelectedImage ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'Refresh';
				icon: (self iconNamed: #smallUpdateIcon);
				help: 'Refresh image table';
				action: [ self refresh ];
				yourself)
			position: ITItemPosition left
]

{ #category : #initialization }
PhLPharoLauncher >> initializeWidgets [

	self initializeToolbar.
	self initializeStatusbar.
	self initializeBody.
	
]

{ #category : #actions }
PhLPharoLauncher >> launchSelectedImageWithSettings [
	PhLLaunchImageCommand new
		setModel: self context;
		execute
]

{ #category : #actions }
PhLPharoLauncher >> launchSelectedImageWithoutSettings [
	PhLLaunchImageWithoutSettingCommand new
		setModel: self context;
		execute
]

{ #category : #initialization }
PhLPharoLauncher >> newFTSmartTable [
	^ FTSmartTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter
]

{ #category : #accessing }
PhLPharoLauncher >> propertyPanel [
	^ propertyPanel
]

{ #category : #accessing }
PhLPharoLauncher >> propertyPanel: anObject [
	propertyPanel := anObject
]

{ #category : #accessing }
PhLPharoLauncher >> refresh [
	self images: PhLDirectoryBasedImageRepository new images.
	imagesTable morph refresh
]

{ #category : #actions }
PhLPharoLauncher >> selectionChanged: anAnnouncement [

	imagesTable morph selectedItems size = 1 ifTrue: [ 
		propertyPanel model: imagesTable morph selectedItems anyOne ].
]

{ #category : #action }
PhLPharoLauncher >> spawnNewImageDialog [
	^ PhLNewImageDialog new openWithSpec. 
]

{ #category : #accessing }
PhLPharoLauncher >> statusBar [
	^ statusBar
]

{ #category : #accessing }
PhLPharoLauncher >> statusBar: anObject [
	statusBar := anObject
]

{ #category : #menu }
PhLPharoLauncher >> subMenu [ 

	^ MenuPresenter new
		addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'Open';
					icon: (self iconNamed: #openIcon);
					shortcut: $o meta;
					action: [ self inform: 'Open' ] ].
			group addItem: [ :item |
				item 
					name: 'Save';
					icon: (self iconNamed: #smallSaveIcon);
					shortcut: $s meta;
					action: [ self inform: 'Save' ] ].
			group addItem: [ :item |
				item 
					name: 'Print';
					shortcut: $p meta;
					icon: (self iconNamed: #smallPrintIcon);
					action: [ self inform: 'Print' ] ].
			group addItem: [ :item |
				item 
					name: 'Kill';
					shortcut: $k meta;
					icon: (self iconNamed: #smallCancelIcon);
					action: [ self inform: 'Kill' ] ] ]
]
