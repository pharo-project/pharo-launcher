"
A simple UI to show locally available Virtual Machines to launch Pharo images.
"
Class {
	#name : #PhLVMPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'vmTable',
		'dataSource',
		'shouldShowPrivateVms',
		'rootCommandsGroup'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #commands }
PhLVMPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildToolbarGroup);
		register: (self buildContextualMenuGroup)
]

{ #category : #commands }
PhLVMPresenter class >> buildContextualMenuGroup [
	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		register: PhLUpdateVmCommand forSpec;
		register: PhLShowVmInFolderCommand forSpec;
		register: PhLDeleteVmCommand forSpec;
		yourself

]

{ #category : #commands }
PhLVMPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher VM Manager toolbar';
		register: PhLUpdateVmCommand forSpec;
		register:
			(PhLShowVmInFolderCommand forSpec
				name: 'Show';
				yourself);
		register: PhLDeleteVmCommand forSpec;
		register: PhLToggleVmPrivateVmCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : #examples }
PhLVMPresenter class >> example [
	<example>
	(self on: PhLVirtualMachinesDataSource default) open
]

{ #category : #initialization }
PhLVMPresenter >> connectPresenters [
	super connectPresenters.
	shouldShowPrivateVms := false.
	

]

{ #category : #accessing }
PhLVMPresenter >> datasource [
	^ self model
]

{ #category : #layout }
PhLVMPresenter >> defaultLayout [
	^ SpBoxLayout newVertical
		add: vmTable;
		yourself
]

{ #category : #initialization }
PhLVMPresenter >> initializePresenters [
	vmTable := self newTable
		whenActivatedDo: [ PhLShowVmInFolderCommand new
									context: self;
									execute  ];
		addColumn: ((SpImageTableColumn title: '' evaluated: 
			[ :vm | | icon |
			icon := vm isValid
				ifTrue: [ self iconNamed: #testGreen ]
				ifFalse: [ self iconNamed: #testNotRun ].
			icon asMorph
				setBalloonText: vm validityDescription;
				yourself.
			]) 
			width: 20);
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 100; yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Last update' 
			evaluated: #lastUpdateTimeDescription) width: 120; yourself);
		addColumn: (SpStringTableColumn title: 'Download URL' evaluated: #downloadUrl);
		showColumnHeaders;
		alternateRowsColor;
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Context Menu' ];
		beResizable;
		beMultipleSelection;
		items: self datasource virtualMachines;
		yourself
]

{ #category : #initialization }
PhLVMPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Locally available Virtual Machines';
		initialExtent: 720 @ 300;
		toolbar:
			(self newLaunchToolbar fillWith: self rootCommandsGroup / 'Toolbar');
		centered.

	self rootCommandsGroup installShortcutsIn: aWindowPresenter.

	self privateVmsTogglePresenter
		whenDeactivatedDo: [ 
			self privateVmsTogglePresenter
				label: 'public';
				icon: (self iconNamed: #remote) ];
		whenActivatedDo: [ 
			self privateVmsTogglePresenter
				label: 'private';
				icon: (self iconNamed: #smallLock) ];
		beUnselected
]

{ #category : #initialization }
PhLVMPresenter >> privateVmsTogglePresenter [
	^ (self rootCommandsGroup / 'Toolbar') allCommands last presenter
]

{ #category : #private }
PhLVMPresenter >> readableDateFor: aTimestamp [
	^ aTimestamp asDate yyyymmdd , ' ' , aTimestamp asTime print24

]

{ #category : #accessing }
PhLVMPresenter >> refresh [ 
	| vms |
	vms := shouldShowPrivateVms
		ifTrue: [ self datasource privateVirtualMachines ]
		ifFalse: [ self datasource virtualMachines ].
	vmTable items: vms.
]

{ #category : #initialization }
PhLVMPresenter >> rootCommandsGroup [ 
	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : #accessing }
PhLVMPresenter >> selectedVms [
	^ vmTable selectedItems
]

{ #category : #configuring }
PhLVMPresenter >> showPrivateVms [
	shouldShowPrivateVms := true.
	self refresh.
]

{ #category : #configuring }
PhLVMPresenter >> showVms [
	shouldShowPrivateVms := false.
	self refresh.
]

{ #category : #configuring }
PhLVMPresenter >> toggleShowVmPrivateVm [
	shouldShowPrivateVms := shouldShowPrivateVms not.
	self refresh
]
