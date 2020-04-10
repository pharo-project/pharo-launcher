"
Pharo Launcher templates window presenting the list of available templates.
Templates are used to create images.

To open me:
	self example
"
Class {
	#name : #PhLTemplatesPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'categoryTable',
		'templateTable',
		'descriptionPanel'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #'as yet unclassified' }
PhLTemplatesPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildContextualMenuGroup)
]

{ #category : #'as yet unclassified' }
PhLTemplatesPresenter class >> buildContextualMenuGroup [
	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		description: 'Templates tree contextual menu';
		register: PhLRenameTemplateCommand forSpec;
		register: PhLRemoveTemplateCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : #specs }
PhLTemplatesPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add: (SpPanedLayout newHorizontal
			add: (SpBoxLayout newVertical 
				add: '1. Choose a template category:' height: self labelHeight;
				add: #categoryTable;
				yourself);
			add: (SpBoxLayout newVertical 
				add: '2. Choose a template:' height: self labelHeight;
				add: #templateTable;
				yourself);
			yourself);
		add: (SpBoxLayout newVertical 
			add: #descriptionPanel;
			yourself);
		yourself		
]

{ #category : #example }
PhLTemplatesPresenter class >> example [
	| app |
	app := PharoLauncherApplication new 
		imageRepository: (PhLDirectoryBasedImageRepository forDirectory: FileSystem memory root);
		yourself.

	^ (self 
			newApplication: app
			model: PhLTemplateGroupRepository default)
		openWithSpec;
		yourself
]

{ #category : #initialization }
PhLTemplatesPresenter >> connectPresenters [

	super connectPresenters.
	categoryTable 
		transmitTo: templateTable 
		transform: [ :group | 
			group 
				ifNil: [ #() ]
				ifNotNil: [ group children ] ].
	templateTable transmitTo: descriptionPanel.
]

{ #category : #accessing }
PhLTemplatesPresenter >> description [
	^ descriptionPanel description
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> hasLocalTemplateSelected [
	| items |
	items := templateTable selectedItems.
	^ items size = 1
		and: [ items first isLocalTemplate ]
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> hasLocalTemplatesSelected [
	| items |
	items := templateTable selectedItems.
	^ items size > 0 
		and: [ items allSatisfy: #isLocalTemplate ]
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> hasSingleTemplateSelected [
	^ (templateTable selection selectedItems size = 1) 
			and: [ templateTable selectedItem isTemplate ]
]

{ #category : #'api -  accessing' }
PhLTemplatesPresenter >> imageName [ 
	^ descriptionPanel imageName
]

{ #category : #'api -  accessing' }
PhLTemplatesPresenter >> imageRepository [
	^ self application imageRepository
]

{ #category : #accessing }
PhLTemplatesPresenter >> initializationScript [
	^ descriptionPanel initializationScript
]

{ #category : #initialization }
PhLTemplatesPresenter >> initializePresenters [
	categoryTable := self newTable
			items: self templateRepository roots;
			addColumn: ((SpImageTableColumn evaluated: #icon) width: 30);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself.
	templateTable := self newTreeTable
		children: #children;
		addColumn: (SpStringTableColumn evaluated: #name);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beMultipleSelection;
		whenBuiltDo: [ :tree | tree widget alternateRowsColor ];
		whenRootsChangedDo: [ :roots | 
			templateTable lazilyComputeChildren: (roots anySatisfy: #shouldComputeChildrenLazily) ]
		yourself.
	descriptionPanel := self
		instantiate: PhLImageCreationPresenter
		on: nil
]

{ #category : #initialization }
PhLTemplatesPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Pharo Launcher - Image creation';
		initialExtent: 800 @ 400;
		"toolBar: (self rootCommandsGroup / 'Toolbar') asToolbarPresenter;"
		centered.	
	"self rootCommandsGroup installShortcutsIn: aWindowPresenter"
]

{ #category : #updating }
PhLTemplatesPresenter >> refresh [
	| selectedCategory |
	selectedCategory := categoryTable selection selectedItem.
	self templateRepository refresh. "refresh caches"
	categoryTable items: categoryTable items.
	categoryTable selectItem: selectedCategory
]

{ #category : #reseting }
PhLTemplatesPresenter >> refreshInitializationScriptList [
	descriptionPanel refreshInitializationScriptList
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> selectCategory: anIndex [
	categoryTable selectIndex: anIndex
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> selectedTemplateCategory [
	^ categoryTable selection selectedItem
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> selectedTemplates [
	^ templateTable selectedItems
]

{ #category : #'api - selection' }
PhLTemplatesPresenter >> singleTemplate [
	self hasSingleTemplateSelected
		ifFalse: [ PhLCommandError  signal ].
	^ templateTable selectedItems first "multiple selection enabled, always return a collection"
]

{ #category : #'api -  accessing' }
PhLTemplatesPresenter >> templateRepository [
	^ self model
]
