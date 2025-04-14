"
Pharo Launcher templates window presenting the list of available templates.
Templates are used to create images.

To open me:
	self example
"
Class {
	#name : 'PhLTemplatesPresenter',
	#superclass : 'SpPresenterWithModel',
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'categoryTable',
		'templateTable',
		'descriptionPanel'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'commands' }
PhLTemplatesPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildContextualMenuGroup)
]

{ #category : 'commands' }
PhLTemplatesPresenter class >> buildContextualMenuGroup [

	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		description: 'Templates tree contextual menu';
		register: PhLRenameTemplateCommand forSpec;
		register: PhLRemoveTemplateCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : 'example' }
PhLTemplatesPresenter class >> example [
	| app |
	app := PharoLauncherApplication new 
		imageRepository: (PhLDirectoryBasedImageRepository forDirectory: FileSystem memory root);
		yourself.

	^ (self 
			newApplication: app
			model: PhLTemplateGroupRepository default)
		open;
		yourself
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> buildCategoryTable [
	
	^ self newList
		items: self templateRepository roots;
		displayIcon: #icon;
		display: #name;
		yourself
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> buildDescriptionPanel [
	| panel |

	panel := self instantiate: PhLImageCreationPresenter on: nil.
	panel disable.
	
	^ panel
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> buildTemplateTable [
	
	^ self newTree
		"alternateRowsColor;"
		children: [ :aTemplateGroup | self templateChildrenOf: aTemplateGroup ];
		display: #name;
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		actions: self rootCommandsGroup / 'Context Menu';
		beMultipleSelection; "bulk delete templates for example"
		whenSelectionChangedDo: [ :selection | 
			descriptionPanel enabled: selection isEmpty not ]
		yourself
]

{ #category : 'private' }
PhLTemplatesPresenter >> categoryChildrenOf: aTemplateGroup [
		
	^ PhLCurrentContext 
		use: self 
		during: [ aTemplateGroup children ]
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> connectPresenters [

	super connectPresenters.
	categoryTable 
		transmitTo: templateTable 
		transform: [ :group | 
			group 
				ifNotNil: [ self categoryChildrenOf: group ]
				ifNil: [ #() ] ].

	templateTable 
		transmitTo: descriptionPanel
		transform: [ :selectionArray | 
			selectionArray
				ifNotEmpty: [ selectionArray last ]
				ifEmpty: [ nil ] ].
]

{ #category : 'layout' }
PhLTemplatesPresenter >> defaultLayout [
	
	^ SpPanedLayout newHorizontal
		positionOfSlider: self initialExtent x * (2/3);
		add: (SpPanedLayout newHorizontal
			positionOfSlider: self initialExtent x * (1/3);
			add: (SpBoxLayout newVertical 
				add: (self newLabel 
						addStyle: 'list_header';
						label: 'Category';
						yourself) 
					expand: false;
				add: categoryTable;
				yourself);
			add: (SpBoxLayout newVertical 
				add: (self newLabel 
						addStyle: 'list_header';
						label: 'Template';
						yourself) 
					expand: false;
				add: templateTable;
				yourself);
			yourself);
		add: descriptionPanel;
	yourself		
]

{ #category : 'accessing' }
PhLTemplatesPresenter >> description [
	^ descriptionPanel description
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> hasLocalTemplateSelected [
	| items |
	items := templateTable selectedItems.
	^ items size = 1
		and: [ items first isLocalTemplate ]
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> hasLocalTemplatesSelected [
	| items |
	items := templateTable selectedItems.
	^ items size > 0 
		and: [ items allSatisfy: #isLocalTemplate ]
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> hasSingleTemplateSelected [
	^ (templateTable selection selectedItems size = 1) 
			and: [ templateTable selectedItem isTemplate ]
]

{ #category : 'api - accessing' }
PhLTemplatesPresenter >> imageName [ 
	^ descriptionPanel imageName
]

{ #category : 'api - accessing' }
PhLTemplatesPresenter >> imageRepository [
	^ self application imageRepository
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> initialExtent [
	
	^ 980@400
]

{ #category : 'accessing' }
PhLTemplatesPresenter >> initializationScript [

	^ descriptionPanel initializationScript
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> initialize [

	super initialize.
	self selectCategoryNamed: 'Official distributions'

]

{ #category : 'initialization' }
PhLTemplatesPresenter >> initializePresenters [

	categoryTable := self buildCategoryTable.
	templateTable := self buildTemplateTable.
	descriptionPanel := self buildDescriptionPanel
]

{ #category : 'initialization' }
PhLTemplatesPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Pharo Launcher - Image creation';
		initialExtent: self initialExtent;
		"toolBar: (self rootCommandsGroup / 'Toolbar') asToolbarPresenter;"
		centered.	
	"self rootCommandsGroup installShortcutsIn: aWindowPresenter"
]

{ #category : 'updating' }
PhLTemplatesPresenter >> refresh [
	| selectedCategory |
	selectedCategory := categoryTable selection selectedItem.
	self templateRepository refresh. "refresh caches"
	categoryTable items: categoryTable items.
	categoryTable selectItem: selectedCategory
]

{ #category : 'reseting' }
PhLTemplatesPresenter >> refreshInitializationScriptList [
	descriptionPanel refreshInitializationScriptList
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> selectCategory: anIndex [
	categoryTable selectIndex: anIndex
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> selectCategoryNamed: categoryName [
	
	|categoryToSelect|
	"don't select anything, if not found"
	categoryToSelect := categoryTable items detect: [:cat | cat name includesSubstring: categoryName ] ifNone: [ ^ self ].
	
	 categoryTable selectItem: categoryToSelect 
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> selectedTemplateCategory [
	^ categoryTable selection selectedItem
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> selectedTemplates [
	^ templateTable selectedItems
]

{ #category : 'api - selection' }
PhLTemplatesPresenter >> singleTemplate [
	self hasSingleTemplateSelected
		ifFalse: [ PhLCommandError  signal: 'Only one template must be selected!' ].
	^ templateTable selectedItems first "multiple selection enabled, always return a collection"
]

{ #category : 'private' }
PhLTemplatesPresenter >> templateChildrenOf: aTemplateGroup [
		
	^ [ aTemplateGroup children ]
		on: PhLDownloadError
		do: [ :error | 
			| children |
			((PhLRetryPresenter newApplication: self application)
				explanation: error longDescription;
				retryBlock: [ children := aTemplateGroup children ];
				cancelBlock: [ children := #() ];
				asModalWindow)
					owner: self window; 
					open.
			children ]	
]

{ #category : 'api - accessing' }
PhLTemplatesPresenter >> templateRepository [

	^ self model
]

{ #category : 'private - updating' }
PhLTemplatesPresenter >> updateTemplateTableWith: aGroup [

		aGroup ifNil: [ 
			templateTable items: #().
			^ self ].
		
		aGroup isUpdated ifTrue: [ 
			templateTable items: aGroup children.
			^ self ].
		
		templateTable items: #().
		[ 
			| children |
			children := self categoryChildrenOf: aGroup.
			templateTable items: children.
		] fork
]
