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
		'imageArgumentsField',
		'selectedConfigurationVmList',
		'vmArgumentsField',
		'saveConfigurationButton'
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
				add: #selectedConfigurationVmList;
				yourself)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				add: 'VM arguments:' withConstraints: self labelConstraintsBlock;
				add: #vmArgumentsField;
				yourself)
			height: 200"80";
		add:
			(SpBoxLayout newHorizontal
				add: 'Image arguments:' withConstraints: self labelConstraintsBlock;
				add: #imageArgumentsField;
				yourself)
			height: 200"150";
		add: 
			(SpBoxLayout newHorizontal
				add: ''; "work-around to center the button"
				add: #saveConfigurationButton width: self buttonWidth;
				add: '  '; "work-around to center the button"
				yourself)
			height: self buttonHeight;
		yourself
]

{ #category : #specs }
PhLLaunchConfigurationPresenter class >> defaultSpec [
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
		model: image) openWithSpec
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

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> image [
	^ image
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> initializePresenters [
	configurationTable := (self instantiate: SpEditableList)
		addItemBlock: [ self application newRequest
			title: 'New Launch configuration name?';
			request ];
		label: 'Launch configurations';
		items: {self image defaultLaunchConfiguration};
		display: #name;
		whenSelectionChangedDo: [ :selection | 
			selectedConfiguration := selection selectedItem
				ifNil: [ PhLNullLaunchConfiguration new ].
			self selectedConfigurationChanged ];
		yourself.
	selectedConfigurationNameField := self newTextInput
		autoAccept: true;
		yourself.
	selectedConfigurationVmList := self newDropList
		items: image vmManager virtualMachines;
		display: [ :each | each id];
		yourself.
	vmArgumentsField := (self instantiate: SpEditableList)
		addItemBlock: [ self application newRequest
			title: 'New VM argument?';
			request ];
		yourself.
	imageArgumentsField := self instantiate: SpEditableList
		yourself.
	saveConfigurationButton := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave);
		yourself.
]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self image name, ' image launch configurations';
		initialExtent: 800@550"400".
]

{ #category : #accessing }
PhLLaunchConfigurationPresenter >> selectedConfiguration [
	^ selectedConfiguration
]

{ #category : #updating }
PhLLaunchConfigurationPresenter >> selectedConfigurationChanged [ 

	selectedConfigurationNameField text: self selectedConfiguration name.
	selectedConfigurationVmList selectItem: self selectedConfiguration vm.
	vmArgumentsField items: self selectedConfiguration vmArguments.
	imageArgumentsField items: self selectedConfiguration imageArguments.

]

{ #category : #initialization }
PhLLaunchConfigurationPresenter >> setModelBeforeInitialization: aPhLImage [
	image := aPhLImage 
]
