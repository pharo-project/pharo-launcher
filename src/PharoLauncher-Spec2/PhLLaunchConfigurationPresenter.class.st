"
Window used to present the list of launch configurations of an image.
You can edit it, add a new one or remove a configuration.

To open me:
	self example
"
Class {
	#name : 'PhLLaunchConfigurationPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'image',
		'configurationTable',
		'selectedConfiguration',
		'selectedConfigurationNameField',
		'vmList',
		'vmArgumentList',
		'imageArgumentList',
		'applyChangesButton',
		'saveAndSelectsButton'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'specs' }
PhLLaunchConfigurationPresenter class >> example [
	| image |
	image := PhLImage example.
	image versionFile 
		writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	(self 
		newApplication: PharoLauncherApplication new 
		model: image) open
]

{ #category : 'specs' }
PhLLaunchConfigurationPresenter class >> labelConstraintsBlock [
	^ [ :constraints | 
	constraints
		height: self labelHeight;
		width: self labelWidth ]
]

{ #category : 'specs' }
PhLLaunchConfigurationPresenter class >> labelWidth [
	^ 120
]

{ #category : 'private' }
PhLLaunchConfigurationPresenter >> addInteractiveImageArgument [
	| interactiveFlag |
	interactiveFlag := '--interactive'.
	(imageArgumentList items includes: interactiveFlag)
		ifTrue: [ ^ self ].
	imageArgumentList items add: interactiveFlag.
	imageArgumentList refresh.
]

{ #category : 'private' }
PhLLaunchConfigurationPresenter >> close [
	
	self withWindowDo: [ :aWindow | 
		aWindow beOk; close ]
]

{ #category : 'layout' }
PhLLaunchConfigurationPresenter >> configurationDetailLayout [
	
	^ SpGridLayout build: [ :builder | builder
		beRowNotHomogeneous;
		beColumnNotHomogeneous;
		borderWidth: 0;
		column: 1 withConstraints: [ :c | c hAlignEnd; vAlignStart ];
		column: 2 withConstraints: [ :c | c beExpand ];
		add: 'Configuration name'; add: selectedConfigurationNameField; nextRow;
		add: 'VM'; add: vmList; nextRow;
		add: 'VM arguments'; add: vmArgumentList; nextRow;
		add: 'Image arguments'; add: imageArgumentList; nextRow ]
]

{ #category : 'accessing' }
PhLLaunchConfigurationPresenter >> configurationName [
	^ selectedConfigurationNameField text
]

{ #category : 'accessing' }
PhLLaunchConfigurationPresenter >> configurations [
	^ configurationTable items
]

{ #category : 'initialization' }
PhLLaunchConfigurationPresenter >> connectPresenters [
	configurationTable selectIndex: 1
]

{ #category : 'layout' }
PhLLaunchConfigurationPresenter >> defaultLayout [

	^ SpPanedLayout newHorizontal
		positionOfSlider: 200;
		add: configurationTable layout: #withoutOrderingBar;
		add: (SpBoxLayout newVertical  
			add: self configurationDetailLayout;
			add: (self newPresenter 
					addStyle: 'action_area';
					layout: (SpBoxLayout newHorizontal
						"hAlignEnd;"
						add: applyChangesButton;
						add: saveAndSelectsButton;
						yourself);
					yourself)
				expand: false;
			yourself);
		yourself
]

{ #category : 'accessing' }
PhLLaunchConfigurationPresenter >> image [
	^ image
]

{ #category : 'accessing' }
PhLLaunchConfigurationPresenter >> imageArguments [
	^ imageArgumentList items
]

{ #category : 'initialization' }
PhLLaunchConfigurationPresenter >> initializePresenters [

	configurationTable := (self instantiate: SpEditableListPresenter)
		addItemBlock: [ self newConfiguration ];
		removeItemBlock: [ :config | self removeLaunchConfiguration: config ];
		label: 'Launch configurations';
		items: self image launchConfigurations;
		display: [ :each | each name ];
		whenSelectionChangedDo: [ :selection | 
			selectedConfiguration := selection selectedItem ifNil: [ PhLNullLaunchConfiguration new ].
			self selectedConfigurationChanged ];
		yourself.
	selectedConfigurationNameField := self newTextInput
		disable;
		yourself.
	vmList := self newDropList
		sortingBlock: [ :a :b | a model id > b model id ];
		display: [ :each | each id ];
		whenSelectedItemChangedDo: [ :vm | 
			vm ifNotNil: 
				[ vm isHeadless 
					ifTrue: [ self addInteractiveImageArgument ] ] ];
		yourself.
	"Run in a separate process to do not block UI. Can take some seconds."
	[ self initializeVmListContent ] fork.
	vmArgumentList := (self instantiate: SpEditableListPresenter)
		addItemBlock: [ 
			self newRequest
				title: 'Add';
				label: 'New VM argument?';
				request ];
		yourself.
	imageArgumentList := (self instantiate: SpEditableListPresenter)
		addItemBlock: [ 
			self newRequest
				title: 'Add';
				label: 'New image argument?';
				request ];
		yourself.
	applyChangesButton := self newButton
		label: 'Apply';
		icon: (self application iconNamed: #scriptManager);
		action: [ self saveSelectedConfiguration ];
		yourself.
	saveAndSelectsButton := self newButton
		label: 'Save & select';
		icon: (self application iconNamed: #smallSave);
		action: [ 
			self saveSelectedConfiguration.
			self close ];
		yourself
]

{ #category : 'initialization' }
PhLLaunchConfigurationPresenter >> initializeVmListContent [
	vmList items: image vmManager virtualMachines.
	self setVmFromConfiguration.
]

{ #category : 'initialization' }
PhLLaunchConfigurationPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self image name, ' image launch configurations';
		initialExtent: 800@550;
		whenClosedDo: [ self application launchConfigurationEdited: self selectedConfiguration ].
]

{ #category : 'action' }
PhLLaunchConfigurationPresenter >> newConfiguration [
	| newName configuration |
	
	newName := self newRequest
		title: 'Create';
		label: 'New launch configuration name?';
		validateAnswer: [ :answer | 
			self image launchConfigurations noneSatisfy: [ :each | each name = answer ] ];
		request.
	newName ifNil: [ ^ nil ].
	
	configuration := (PhLLaunchConfiguration withImage: self image)
		name: newName;
		yourself.
	
	self image addLaunchConfiguration: configuration.
	^ configuration
]

{ #category : 'action' }
PhLLaunchConfigurationPresenter >> removeLaunchConfiguration: config [

	self image removeLaunchConfiguration: config.
	configurationTable items: self image launchConfigurations
]

{ #category : 'action' }
PhLLaunchConfigurationPresenter >> saveSelectedConfiguration [
	| config |
	config := self selectedConfiguration.
	config isNullConfiguration ifTrue: [ ^ self ].
	
	config imageArguments: imageArgumentList items.
	config vmArguments: vmArgumentList items.
	config vm: vmList selectedItem.

	self image lastUsedConfiguration: config.
	self application launchConfigurationEdited: config.
]

{ #category : 'action' }
PhLLaunchConfigurationPresenter >> selectImageArgumentAt: anIndex [
	imageArgumentList selectIndex: anIndex
]

{ #category : 'action' }
PhLLaunchConfigurationPresenter >> selectVMArgumentAt: anIndex [
	vmArgumentList selectIndex: anIndex
]

{ #category : 'accessing' }
PhLLaunchConfigurationPresenter >> selectedConfiguration [
	^ selectedConfiguration
]

{ #category : 'updating' }
PhLLaunchConfigurationPresenter >> selectedConfigurationChanged [
	selectedConfigurationNameField text: self selectedConfiguration name.
	self setVmFromConfiguration.
	vmArgumentList items: self selectedConfiguration vmArguments.
	imageArgumentList items: self selectedConfiguration imageArguments.
	self selectImageArgumentAt: 1.
	self selectVMArgumentAt: 1.
]

{ #category : 'initialization' }
PhLLaunchConfigurationPresenter >> setModelBeforeInitialization: aPhLImage [
	image := aPhLImage 
]

{ #category : 'updating' }
PhLLaunchConfigurationPresenter >> setVmFromConfiguration [
	| vm |
	vm := self selectedConfiguration 
		ifNil: [ ^ self "abort if no launch configuration selected" ]
		ifNotNil: [ :config | config vm ].
	[ vmList selectItem: vm ]
		on: NotFound
		do: [ vmList
				addItemLabeled: vm do: [ "no action" ];
				selectItem: vm ]
]

{ #category : 'accessing' }
PhLLaunchConfigurationPresenter >> vmArguments [
	^ vmArgumentList items
]
