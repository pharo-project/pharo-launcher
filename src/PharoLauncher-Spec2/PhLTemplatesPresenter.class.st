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

{ #category : #specs }
PhLTemplatesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 5;
		add: (SpBoxLayout newHorizontal
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

	(self on: PhLTemplateGroupRepository default) 
		application: app;
		openWithSpec
]

{ #category : #initialization }
PhLTemplatesPresenter >> connectPresenters [

	super connectPresenters.
	categoryTable transmitTo: templateTable transform: [ :group | group children ].
	templateTable transmitTo: descriptionPanel.
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

{ #category : #initialization }
PhLTemplatesPresenter >> initializePresenters [
	categoryTable := "self newList
		items: self model roots;
		display: #name;
		yourself."
		self newTable
			items: self templateRepository roots;
			addColumn: ((SpImageTableColumn evaluated: #icon) width: 30);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself.
	templateTable := self newTreeTable
		children: #children;
		addColumn: (SpStringTableColumn evaluated: #name);
		beMultipleSelection;
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
		whenBuiltDo: [ :ann | ann model centered ].	
	"self rootCommandsGroup installShortcutsIn: aWindowPresenter"
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
