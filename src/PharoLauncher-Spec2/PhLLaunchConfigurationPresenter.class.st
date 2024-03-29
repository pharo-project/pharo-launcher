"
Window used to present the list of launch configurations of an image.
You can edit it, add a new one or remove a configuration.

To open me:
	self example
"
Class {
	#name : #PhLLaunchConfigurationPresenter,
	#superclass : #SpPresenter,
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
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLLaunchConfigurationPresenter class >> configurationDetailSpec [
	^ SpBoxLayout newVertical
		spacing: 5;
		add:
			(SpBoxLayout newHorizontal
				add: 'Configuration name:' withConstraints: self labelConstraintsBlock;
				add: #selectedConfigurationNameField;
				yourself)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				add: 'VM:' withConstraints: self labelConstraintsBlock;
				add: #vmList;
				yourself)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				add: 'VM arguments:' withConstraints: self labelConstraintsBlock;
				add: #vmArgumentList;
				yourself)
			height: 200"80";
		add:
			(SpBoxLayout newHorizontal
				add: 'Image arguments:' withConstraints: self labelConstraintsBlock;
				add: #imageArgumentList;
				yourself)
			height: 200"150";
		add: 
			(SpBoxLayout newHorizontal
				add: ''; "work-around to center the button"
				add: #applyChangesButton expand: false;
				add: '   ' expand: false;
				add: #saveAndSelectsButton expand: false;
				add: '  '; "work-around to center the button"
				yourself)
			height: self buttonHeight;
		yourself
]

{ #category : #layout }
PhLLaunchConfigurationPresenter class >> defaultLayout [
	^ SpBoxLayout newHorizontal
		spacing: 5;
		add: #configurationTable 
			withConstraints: [ :constraints | 
				constraints 
					spec: #withoutOrderingBar; 
					width: 200 ];
		add: self configurationDetailSpec;
		yourself
]

{ #category : #specs }
PhLLaunchConfigurationPresenter class >> example [
	| image |
	image := PhLImage example.
	image versionFile 
		writeStreamDo: [ :stream | stream nextPutAll: '70' ].
	(self 
		newApplication: PharoLauncherApplication new 
		model: image) open
]

{ #category : #specs }
PhLLaunchConfigurationPresenter class >> labelConstraintsBlock [
	^ [ :constraints | 
	constraints
		height: self labelHeight;
		width: self labelWidth ]
]

{ #category : #specs }
PhLLaunchConfigurationPresenter class >> labelWidth [
	^ 120
]

{ #category : #private }
PhLLaunchConfigurationPresenter >> addInteractiveImageArgument [
	| interactiveFlag |
	interactiveFlag := '--interactive'.
	(imageArgumentList items includes: interactiveFlag)
		ifTrue: [ ^ self ].
	imageArgumentList items add: interactiveFlag.
	imageArgumentList refresh.
]

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> configurationName [
	^ selectedConfigurationNameField text
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> connectPresenters [
	configurationTable selectIndex: 1
]

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> image [
	^ image
]

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> imageArguments [
	^ imageArgumentList items
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> initializePresenters [

	configurationTable := (self instantiate: SpEditableListPresenter)
		addItemBlock: [ self newConfiguration ];
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
				title: 'New VM argument?';
				request ];
		yourself.
	imageArgumentList := (self instantiate: SpEditableListPresenter)
		addItemBlock: [ 
			self newRequest
				title: 'New image argument?';
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
			self delete ];
		yourself
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> initializeVmListContent [
	vmList items: image vmManager virtualMachines.
	self setVmFromConfiguration.
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self image name, ' image launch configurations';
		initialExtent: 800@550;
		whenClosedDo: [ self application launchConfigurationEdited: self selectedConfiguration ].
]

{ #category : #action }
PhLLaunchConfigurationPresenter >> newConfiguration [
	| newName configuration |
	
	newName := self application newRequest
			title: 'New Launch configuration name?';
			validateAnswer: [ :answer | 
				self image launchConfigurations noneSatisfy: [ :each | each name = answer ] ];
			request.
	newName ifNil: [ ^ nil ].
	
	configuration := (PhLLaunchConfiguration  withImage: self image)
		name: newName;
		yourself.
	^ configuration
]

{ #category : #action }
PhLLaunchConfigurationPresenter >> saveSelectedConfiguration [
	| config |
	config := self selectedConfiguration.
	config isNullConfiguration ifTrue: [ ^ self ].
	
	config imageArguments: imageArgumentList items.
	config vmArguments: vmArgumentList items.
	config vm: vmList selectedItem.
	self image serializeMetadata.
	self application launchConfigurationEdited: config.
]

{ #category : #action }
PhLLaunchConfigurationPresenter >> selectImageArgumentAt: anIndex [
	imageArgumentList selectIndex: anIndex
]

{ #category : #action }
PhLLaunchConfigurationPresenter >> selectVMArgumentAt: anIndex [
	vmArgumentList selectIndex: anIndex
]

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> selectedConfiguration [
	^ selectedConfiguration
]

{ #category : #updating }
PhLLaunchConfigurationPresenter >> selectedConfigurationChanged [
	selectedConfigurationNameField text: self selectedConfiguration name.
	self setVmFromConfiguration.
	vmArgumentList items: self selectedConfiguration vmArguments.
	imageArgumentList items: self selectedConfiguration imageArguments.
	self selectImageArgumentAt: 1.
	self selectVMArgumentAt: 1.
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> setModelBeforeInitialization: aPhLImage [
	image := aPhLImage 
]

{ #category : #updating }
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

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> vmArguments [
	^ vmArgumentList items
]
