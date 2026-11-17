"
Pharo Launcher main window presenting the list of managed images as well as a toolbar and a status bar.

To open me:
	(self on: PhLDirectoryBasedImageRepository default) openWithSpec
"
Class {
	#name : 'PhLImagesPresenter',
	#superclass : 'SpPresenterWithModel',
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'imageTable',
		'descriptionPanel',
		'imageFilter',
		'rootCommandsGroup',
		'toolbar',
		'vmsToUpdate',
		'editConfigurationButton'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'commands' }
PhLImagesPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [

	rootCommandGroup
		register: (self buildToolbarGroupContext: anImagesPresenter);
		register: (self buildContextualMenuGroupContext: anImagesPresenter)
]

{ #category : 'commands' }
PhLImagesPresenter class >> buildContextualMenuGroupContext: aContext [

	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		beDisplayedAsGroup;
		description: 'Images table contextual menu';
		register: ((CmCommandGroup named: 'launch') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLLaunchImageCommand forSpecContext: aContext);
			register: (PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand
				context: aContext;
				name: 'Launch without settings';
				yourself);
			yourself);
		register: ((CmCommandGroup named: 'edition') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLOpenLaunchConfigurationEditorCommand forSpecContext: aContext);
			register: (PhLRenameImageCommand forSpecContext: aContext);
			register: (PhLCopyImageCommand forSpecContext: aContext);
			yourself);
		register: (PhLShowImageInFolderCommand forSpecContext: aContext);
		register: (PhLCopyPathname forSpecContext: aContext);
		register: (PhLCopyLaunchCommand forSpecContext: aContext);
		register: (PhLCreateTemplateFromImageCommand forSpecContext: aContext);
		register: (PhLCreateTemplateFromImageCommand new asSpecCommandWithImageRemoval
			context: aContext;
			yourself);
		register: ((CmCommandGroup named: 'DANGER ZONE') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLRecreateImageCommand forSpecContext: aContext);
			register: (PhLDeleteImageCommand forSpecContext: aContext);
			yourself);
		in: [ :commandGroup | 
			aContext application isMorphicBackend ifTrue: [ 
				commandGroup register: 
					((CmCommandGroup named: 'extra') asSpecGroup
						register: (PhLInspectCommand forSpecContext: aContext);
					yourself) ] ];
		yourself
]

{ #category : 'commands' }
PhLImagesPresenter class >> buildToolbarGroupContext: aContext [

	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher toolbar';
		register: ((CmCommandGroup named: 'Create') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLOpenNewImageWindowCommand forSpecContext: aContext);
			register: (PhLImportImageCommand forSpecContext: aContext);
			register: (PhLLaunchImageFromDiskCommand forSpecContext: aContext);
			register: (PhLRefreshImageRepositoryCommand forSpecContext: aContext);
			yourself);
		register: ((CmCommandGroup named: 'Image') asSpecGroup
			beDisplayedAsGroup;
			register: (PhLLaunchImageCommand forSpecContext: aContext);
			register: (PhLLaunchImageCommand new asSpecLaunchWithoutSettingsCommand
				context: aContext;
				yourself);
			register: ((PhLShowImageInFolderCommand forSpecContext: aContext)
				name: 'Show';
				yourself);
			register: (PhLDeleteImageCommand forSpecContext: aContext);
			yourself);
		register: ((CmCommandGroup named: 'Settings') asSpecGroup
			register: ((PhLOpenVmManagerCommand forSpecContext: aContext)
				name: 'VMs';
				yourself);
			register: ((PhLOpenSettingsCommand forSpecContext: aContext)
				name: 'Settings';
				yourself);
			register: (PhLAboutCommand forSpecContext: aContext);
			register: (PhLQuitCommand forSpecContext: aContext);
			yourself;
		yourself)
]

{ #category : 'accessing' }
PhLImagesPresenter >> aboutButton [

	^ self aboutCommand presenter
]

{ #category : 'accessing' }
PhLImagesPresenter >> aboutCommand [

	^ self toolbarGroup allCommands detect: [ :each | each decoratedCommand isKindOf: PhLAboutCommand ]
]

{ #category : 'api - actions' }
PhLImagesPresenter >> actionFilter [
	^ imageFilter
		takeKeyboardFocus
]

{ #category : 'api - actions' }
PhLImagesPresenter >> actionLaunch [
	| cmd |

	cmd := PhLLaunchImageCommand forContext: self.
	cmd execute
]

{ #category : 'initialization' }
PhLImagesPresenter >> buildDescriptionPanel [

	^ self
		instantiate: PhLImageDetailPresenter
		on: PhLNullImage new
]

{ #category : 'initialization' }
PhLImagesPresenter >> buildImageFilter [
			
	^ self newTextInput
		placeholder: 'Enter image name filter ...';
		whenTextChangedDo: [ :filterString | self filter: filterString asLowercase ];
		yourself
]

{ #category : 'initialization' }
PhLImagesPresenter >> buildImageTable [

	^ self newTable
		  activateOnDoubleClick;
		  keepAlternateRowsColor;
		  sortingBlock: #lastModification descending;
		  whenActivatedDo: [ self actionLaunch ];
		  addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name)
				   width: 350;
				   beSortable;
				   yourself);
		  addColumn: ((SpStringTableColumn title: 'Architecture' evaluated: #architecture)
				   width: 90;
				   beSortable;
				   yourself);
		  addColumn: ((SpStringTableColumn title: 'Pharo Version' evaluated: #pharoVersion)
				   width: 90;
				   beSortable;
				   yourself);
		  addColumn: ((SpStringTableColumn title: 'Last modified' evaluated: [ :image | self readableDateFor: image lastModification ])
				   sortFunction: #lastModification descending;
				   displayColor: [ :image | self lastModificationColorFor: image lastModification ];
				   yourself);
		  actions: (SpActionGroup new
				   add: self rootCommandsGroup / self contextMenuCommandGroupName;
				   addShortcutWith: [ :action |
						   action
							   shortcutKey: Character cr asKeyCombination;
							   action: [ self actionLaunch ] ];
				   yourself);
		  beResizable;
		  beMultipleSelection;
		  yourself
]

{ #category : 'initialization' }
PhLImagesPresenter >> buildToolbar [
	| toolbarGroup |
	
	toolbarGroup := self toolbarGroup.
	^ self newPresenter
		layout: (SpBoxLayout newLeftToRight
			add: (self newLaunchToolbar fillWith: toolbarGroup / 'Create') expand: false;
			"add: self newLabel;
			add: (SpBoxLayout newLeftToRight 
					vAlignCenter;
					add: self newLaunchConfigurationDropList expand: true;
					add: self newEditConfigurationButton expand: false; 
					yourself)
				expand: false;
			add: (self newLaunchToolbar fillWith: toolbarGroup / 'Image') expand: false;"
			add: self newLabel; "to create a space"
			addLast: (self newLaunchToolbar fillWith: toolbarGroup / 'Settings') expand: false;
			yourself);
		yourself
]

{ #category : 'initialization' }
PhLImagesPresenter >> connectPresenters [

	imageTable transmitDo: [ :image |
		self updateToolbarCommandsAvailability ].

	imageTable 
		transmitTo: descriptionPanel
		transform: [ :images | 		
			images size = 1
				ifTrue: [ images first ]
				ifFalse: [ PhLNullImage new ] ]
]

{ #category : 'api - accessing' }
PhLImagesPresenter >> contextMenuCommandGroupName [

	^ 'Context Menu'
]

{ #category : 'api - actions' }
PhLImagesPresenter >> createLocalTemplateFromSelectionNamed: aString [
	^ self templateRepository createLocalTemplateFrom: self singleImage named: aString
]

{ #category : 'api - focus' }
PhLImagesPresenter >> defaultKeyboardFocus [

	^ imageTable
]

{ #category : 'layout' }
PhLImagesPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: toolbar expand: false;
		add: imageFilter expand: false;
		add: (SpPanedLayout newTopToBottom
			positionOfSlider: self initialExtent y * (35 percent);
			add: imageTable;
			add: descriptionPanel;
			yourself);
		yourself
]

{ #category : 'private' }
PhLImagesPresenter >> editLaunchConfigurations [
	^ (PhLOpenLaunchConfigurationEditorCommand forContext: self) execute
]

{ #category : 'private' }
PhLImagesPresenter >> ensure: aBoolean [
	aBoolean
		ifFalse: [ PhLCommandError signal ]
]

{ #category : 'computing' }
PhLImagesPresenter >> ensurePharoVersionFor: anImage [
	[ anImage ensurePharoVersion ]
	on: PhLImageVersionFileNotFound 
	do: [ :error | 
		| presenter |
		presenter := self instantiate: PhLPharoVersionChooserPresenter.
		presenter openModal.
		presenter version ifNil: [ error pass ].
		anImage versionFile 
			writeStreamDo: [ :stream | stream nextPutAll: presenter version ] ]
]

{ #category : 'private' }
PhLImagesPresenter >> filter: regexMatcher [

	| images |
	images := regexMatcher
		ifNil: [ self imageRepository images ]
		ifNotNil: [ self imageRepository images
				select: [ :each | regexMatcher search: each name asString asLowercase ] ].
	imageTable items: images
]

{ #category : 'api - selection' }
PhLImagesPresenter >> hasSingleImageSelected [
	^ (imageTable selectedItems size = 1) and: [ imageTable selectedItems first isNotNil ]
]

{ #category : 'api - accessing' }
PhLImagesPresenter >> imageRepository [
	^ self model
]

{ #category : 'initialization' }
PhLImagesPresenter >> initialExtent [
		
	^ 900@750
]

{ #category : 'initialization' }
PhLImagesPresenter >> initializePresenters [

	self addStyle: 'launcher'.
	imageFilter := self buildImageFilter.
	imageTable := self buildImageTable.
	descriptionPanel := self buildDescriptionPanel.
	toolbar := self buildToolbar.
	
	self imageRepository 
		whenChangedSend: #refresh
		to: self.
	"The result of previous checks is stored: show it without waiting for the next check"
	self whenBuiltDo: [
		self refreshVmUpdates.
		self refreshLauncherUpdate ]
]

{ #category : 'initialization' }
PhLImagesPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Pharo Launcher';
		initialExtent: self initialExtent;
		centered;
		whenClosedDo: [ self imageRepository unsubscribe: self ].
	"self rootCommandsGroup installShortcutsIn: aWindowPresenter."
	aWindowPresenter 
		addShortcutWith: [ :action | action 
			shortcutKey: $f actionModifier;
			action: [ self actionFilter ] ]
]

{ #category : 'private' }
PhLImagesPresenter >> lastModificationColorFor: aDateAndTime [

	| age |
	age := DateAndTime now - aDateAndTime.
	age days < 3 ifTrue: [ ^ Color fromHexString: '009688' ].
	age days < 8 ifTrue: [ ^ Color fromHexString: '4CAF50' ].
	age days < 31 ifTrue: [ ^ Color fromHexString: 'FF9800' ].
	^ Color fromHexString: '90A4AE'
]

{ #category : 'initialization' }
PhLImagesPresenter >> newEditConfigurationButton [
		
	^ editConfigurationButton := self newButton
		addStyle: 'flat';
		icon: (self iconNamed: #edit);
		action: [ self editLaunchConfigurations ];
		yourself
]

{ #category : 'private' }
PhLImagesPresenter >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime
]

{ #category : 'updating' }
PhLImagesPresenter >> refresh [ 

	imageTable 
		unselectAll;
		items: self imageRepository images
]

{ #category : 'launcher update' }
PhLImagesPresenter >> refreshLauncherUpdate [
	"Show the newer launcher found by the last check. The server is not asked."

	| checker |
	checker := self application launcherUpdateChecker.
	self showLauncherUpdate: (checker isUpdateAvailable
			 ifTrue: [ checker latestVersion ]
			 ifFalse: [ nil ])
]

{ #category : 'vm updates' }
PhLImagesPresenter >> refreshVmUpdates [
	"Show the VMs to update found by the last check. The server is not asked."

	self showVmUpdates: self application vmUpdateChecker vmsToUpdate
]

{ #category : 'initialization' }
PhLImagesPresenter >> rootCommandsGroup [

	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : 'accessing' }
PhLImagesPresenter >> selectConfiguration: aLaunchConfiguration [
	
	descriptionPanel model: aLaunchConfiguration image
]

{ #category : 'api - selection' }
PhLImagesPresenter >> selectImage: aPhLImage [
	"Select the displayed row of the image.
	 #selectItem: cannot be used: it selects the index of the item in the model items,
	 which is not the displayed one once the table is sorted by a column."

	(1 to: imageTable listSize)
		detect: [ :index | (imageTable itemAt: index) name = aPhLImage name ]
		ifFound: [ :index | imageTable selectIndex: index ]
]

{ #category : 'api - selection' }
PhLImagesPresenter >> selectImageAt: anIndex [
	imageTable selectIndex: anIndex
]

{ #category : 'api - selection' }
PhLImagesPresenter >> selectImagesAt: aLisOfIndexes [
	imageTable selectIndexes: aLisOfIndexes
]

{ #category : 'api - selection' }
PhLImagesPresenter >> selectedImages [
	^ imageTable selectedItems
]

{ #category : 'api - accessing' }
PhLImagesPresenter >> selectedLaunchConfiguration [
	
	^ descriptionPanel selectedLaunchConfiguration
		ifNil: [ self singleImage defaultLaunchConfiguration ]
		ifNotNil: [ :launchConfig | launchConfig ]
]

{ #category : 'launcher update' }
PhLImagesPresenter >> showLauncherUpdate: aVersionOrNil [
	"Warn the user without interrupting: a red badge on the About button tells that a newer launcher is published"

	self aboutButton
		icon: (PhLBadgedIcon
				 icon: self aboutCommand icon
				 count: (aVersionOrNil ifNil: [ 0 ] ifNotNil: [ 1 ])) asForm;
		help: (aVersionOrNil
				 ifNil: [ self aboutCommand decoratedCommand description ]
				 ifNotNil: [ 'Pharo Launcher {1} is available' format: { aVersionOrNil } ])
]

{ #category : 'vm updates' }
PhLImagesPresenter >> showVmUpdates: virtualMachines [
	"Warn the user without interrupting: a red badge on the VMs button tells how many VMs can be updated"

	vmsToUpdate := virtualMachines.
	self vmsButton
		icon: (PhLBadgedIcon icon: self vmManagerCommand decoratedCommand icon count: virtualMachines size) asForm;
		help: (virtualMachines
				 ifEmpty: [ 'Open the VM manager' ]
				 ifNotEmpty: [ 'Updates are available for virtual machines' ])
]

{ #category : 'api - selection' }
PhLImagesPresenter >> singleImage [
	self ensure: self hasSingleImageSelected.
	^ imageTable selection selectedItems first
]

{ #category : 'api - selection' }
PhLImagesPresenter >> singleImageName [
	^ self singleImage name
]

{ #category : 'api - accessing' }
PhLImagesPresenter >> templateRepository [
	^ self application templateRepository
]

{ #category : 'accessing' }
PhLImagesPresenter >> toolbarGroup [
	^ self rootCommandsGroup / 'Toolbar'
]

{ #category : 'initialization' }
PhLImagesPresenter >> updatePresenter [

	self imageRepository hasImages 
		ifTrue: [ 
			imageTable 
				items: self imageRepository images;
				selectFirst ]
		ifFalse: [ 
			imageTable items: #() ]

]

{ #category : 'updating' }
PhLImagesPresenter >> updateToolbarCommandsAvailability [

	"editConfigurationButton enabled: imageTable selectedItem notNil."
	self withToolbarDo: [ :toolbar |
		self toolbarGroup allCommands do: #updateEnableStatus ]
]

{ #category : 'accessing' }
PhLImagesPresenter >> vmManagerCommand [

	^ self toolbarGroup allCommands detect: [ :each |
		  each decoratedCommand isKindOf: PhLOpenVmManagerCommand ]
]

{ #category : 'accessing' }
PhLImagesPresenter >> vmsButton [

	^ self vmManagerCommand presenter
]

{ #category : 'vm updates' }
PhLImagesPresenter >> vmsToUpdate [

	^ vmsToUpdate ifNil: [ #(  ) ]
]

{ #category : 'private' }
PhLImagesPresenter >> withToolbarDo: aBlock [

	self withWindowDo: [ :window | aBlock value: window toolbar ]
]
