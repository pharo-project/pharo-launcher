"
A simple UI to show locally available Virtual Machines to launch Pharo images.
"
Class {
	#name : 'PhLVMPresenter',
	#superclass : 'SpPresenterWithModel',
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'vmTable',
		'rootCommandsGroup',
		'publishedStamps'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'commands' }
PhLVMPresenter class >> buildCommandsGroupWith: anImagesPresenter forRoot: rootCommandGroup [
	rootCommandGroup
		register: (self buildToolbarGroup);
		register: (self buildContextualMenuGroup)
]

{ #category : 'commands' }
PhLVMPresenter class >> buildContextualMenuGroup [
	^ (CmCommandGroup named: 'Context Menu') asSpecGroup
		beDisplayedAsGroup;
		register: PhLUpdateVmCommand forSpec;
		register: PhLShowVmInFolderCommand forSpec;
		register: ((CmCommandGroup named: 'DANGER ZONE') asSpecGroup
			beDisplayedAsGroup;
			register: PhLDeleteVmCommand forSpec;
			yourself);
		yourself

]

{ #category : 'commands' }
PhLVMPresenter class >> buildToolbarGroup [
	^ (CmCommandGroup named: 'Toolbar') asSpecGroup
		description: 'Pharo Launcher VM Manager toolbar';
		register: PhLUpdateVmCommand forSpec;
		register:
			(PhLShowVmInFolderCommand forSpec
				name: 'Show';
				yourself);
		register: PhLDeleteVmCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : 'examples' }
PhLVMPresenter class >> example [
	<example>
	(self on: PhLVirtualMachinesDataSource default) open
]

{ #category : 'updating' }
PhLVMPresenter >> checkForUpdates [

	self showUpdatesFor: self fetchPublishedStamps
]

{ #category : 'updating' }
PhLVMPresenter >> checkForUpdatesInBackground [
	"Asking the server can take time: do not block the UI. The table is refreshed by the UI process."

	PhLVmUpdateChecker shouldRun ifFalse: [ ^ self ].
	[
	| stamps |
	stamps := self fetchPublishedStamps.
	self application defer: [ self showUpdatesFor: stamps ] ]
		forkAt: Processor userBackgroundPriority
		named: 'Launcher VM manager update check'
]

{ #category : 'accessing' }
PhLVMPresenter >> datasource [
	^ self model
]

{ #category : 'layout' }
PhLVMPresenter >> defaultLayout [
	^ SpBoxLayout newVertical
		add: vmTable;
		yourself
]

{ #category : 'private - actions' }
PhLVMPresenter >> doShowInFolder [
		
	PhLShowVmInFolderCommand new
		context: self;
		execute 
]

{ #category : 'private' }
PhLVMPresenter >> fetchPublishedStamps [
	"Answer the stamp of the archive published for each installed VM, by VM id. The stamp is nil when the server does not answer."

	^ ((self datasource virtualMachines select: [ :vm | vm isUpdatable ])
		collect: [ :vm | vm id -> vm publishedStamp ]) asDictionary
]

{ #category : 'testing' }
PhLVMPresenter >> hasUpdateAvailable: aVm [
	"Rely on the stamps fetched by the last check: a VM is no more outdated once updated."

	^ (self publishedStamps at: aVm id ifAbsent: [ nil ])
		ifNil: [ false ]
		ifNotNil: [ :stamp | aVm isOutdatedBy: stamp ]
]

{ #category : 'private' }
PhLVMPresenter >> iconFor: vm [
	| icon |
	
	icon := vm isValid
		ifTrue: [ self iconNamed: #testGreen ]
		ifFalse: [ self iconNamed: #testNotRun ].
	
	^ icon asMorph
		setBalloonText: vm validityDescription;
		yourself
]

{ #category : 'initialization' }
PhLVMPresenter >> initialExtent [
	
	^ 850@450
]

{ #category : 'initialization' }
PhLVMPresenter >> initializePresenters [

	self addStyle: 'launcher'.
	vmTable := self newTable
		whenActivatedDo: [ self doShowInFolder ];
		addColumn: ((SpImageTableColumn title: '' evaluated: [ :vm | self iconFor: vm ]) width: 20);
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 150; yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Last update' 
			evaluated: #lastUpdateTimeDescription) width: 150; yourself);
		addColumn: (SpStringTableColumn
			title: 'Update'
			evaluated: [ :vm | self updateDescriptionFor: vm ]) beNotExpandable;
		addColumn: (SpStringTableColumn title: 'Download URL' evaluated: #downloadUrl);
		showColumnHeaders;
		alternateRowsColor;
		actions: (SpActionGroup new
			add: self rootCommandsGroup / 'Context Menu';
			yourself);
		beResizable;
		beMultipleSelection;
		items: self datasource virtualMachines;
		yourself
]

{ #category : 'initialization' }
PhLVMPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Locally available Virtual Machines';
		initialExtent: self initialExtent;
		toolbar: (self newLaunchToolbar fillWith: self rootCommandsGroup / 'Toolbar');
		centered.

	"self rootCommandsGroup installShortcutsIn: aWindowPresenter."
]

{ #category : 'private' }
PhLVMPresenter >> publishedStamps [

	^ publishedStamps ifNil: [ publishedStamps := Dictionary new ]
]

{ #category : 'private' }
PhLVMPresenter >> readableDateFor: aTimestamp [
	^ aTimestamp asDate yyyymmdd , ' ' , aTimestamp asTime print24

]

{ #category : 'refreshing' }
PhLVMPresenter >> refresh [ 
	vmTable items: self datasource virtualMachines
]

{ #category : 'initialization' }
PhLVMPresenter >> rootCommandsGroup [ 
	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : 'accessing' }
PhLVMPresenter >> selectedVms [
	^ vmTable selectedItems
]

{ #category : 'updating' }
PhLVMPresenter >> showUpdatesFor: stampsByVmId [

	publishedStamps := stampsByVmId.
	self refresh
]

{ #category : 'accessing' }
PhLVMPresenter >> updateDescriptionFor: aVm [

	^ (self hasUpdateAvailable: aVm)
		ifTrue: [ 'Update available' ]
		ifFalse: [ '' ]
]
