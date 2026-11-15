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
		'detailPanel',
		'rootCommandsGroup',
		'publishedStamps',
		'versions'
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
		register: PhLDeleteVmCommand forSpec;
		beDisplayedAsGroup;
		yourself
]

{ #category : 'examples' }
PhLVMPresenter class >> example [
	<example>
	(self on: PhLVirtualMachinesDataSource default) open
]

{ #category : 'initialization' }
PhLVMPresenter >> connectPresenters [

	vmTable
		transmitTo: detailPanel
		transform: [ :vms |
			vms size = 1
				ifTrue: [ vms first ]
				ifFalse: [ nil ] ]
]

{ #category : 'accessing' }
PhLVMPresenter >> datasource [
	^ self model
]

{ #category : 'layout' }
PhLVMPresenter >> defaultLayout [
	^ SpPanedLayout newTopToBottom
		positionOfSlider: 60 percent;
		add: vmTable;
		add: detailPanel;
		yourself
]

{ #category : 'accessing' }
PhLVMPresenter >> detailPanel [

	^ detailPanel
]

{ #category : 'private - actions' }
PhLVMPresenter >> doShowInFolder [
		
	PhLShowVmInFolderCommand new
		context: self;
		execute 
]

{ #category : 'updating' }
PhLVMPresenter >> fetchDetails [
	"Fetch the version of the VMs and their available updates, then show them."

	self showVersions: self fetchVersions updates: self fetchPublishedStamps
]

{ #category : 'updating' }
PhLVMPresenter >> fetchDetailsInBackground [
	"Running the VMs and asking the server can take time: do not block the UI. The table is refreshed by the UI process."

	[
	| fetchedVersions stamps |
	fetchedVersions := self fetchVersions.
	stamps := PhLVmUpdateChecker shouldRun
		          ifTrue: [ self fetchPublishedStamps ]
		          ifFalse: [ Dictionary new ].
	self application defer: [ self showVersions: fetchedVersions updates: stamps ] ]
		forkAt: Processor userBackgroundPriority
		named: 'Launcher VM manager details'
]

{ #category : 'private' }
PhLVMPresenter >> fetchPublishedStamps [
	"Answer the stamp of the archive published for each installed VM, by VM id. The stamp is nil when the server does not answer."

	^ ((self datasource virtualMachines select: [ :vm | vm isUpdatable ])
		collect: [ :vm | vm id -> vm publishedStamp ]) asDictionary
]

{ #category : 'private' }
PhLVMPresenter >> fetchVersions [
	"Answer the version of each VM, by VM id."

	^ (self datasource virtualMachines collect: [ :vm | vm id -> vm version ]) asDictionary
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
	detailPanel := self instantiate: PhLVMDetailPresenter on: nil.
	vmTable := self newTable
		whenActivatedDo: [ self doShowInFolder ];
		addColumn: ((SpImageTableColumn title: '' evaluated: [ :vm | self iconFor: vm ]) width: 20);
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) width: 150; yourself);
		addColumn: (SpStringTableColumn
			title: 'Version'
			evaluated: [ :vm | self versionDescriptionFor: vm ]);
		addColumn: (SpStringTableColumn
			title: 'Status'
			evaluated: [ :vm | self statusFor: vm ]);
		showColumnHeaders;
		alternateRowsColor;
		actions: (SpActionGroup new
			add: self rootCommandsGroup / 'Context Menu';
			yourself);
		beResizable;
		beMultipleSelection;
		items: self datasource virtualMachines;
		yourself.
	self whenBuiltDo: [ self fetchDetailsInBackground ]
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
PhLVMPresenter >> publishedStampOf: aVm [
	"Answer the stamp of the archive published for the VM by the last check, nil if the server did not answer."

	^ publishedStamps at: aVm id ifAbsent: [ nil ]
]

{ #category : 'private' }
PhLVMPresenter >> readableDateFor: aTimestamp [
	^ aTimestamp asDate yyyymmdd , ' ' , aTimestamp asTime print24

]

{ #category : 'refreshing' }
PhLVMPresenter >> refresh [
	"Keep the selection: the details of the selected VM are shown again with what was fetched"

	| selection |
	selection := vmTable selectedItems.
	vmTable items: self datasource virtualMachines.
	vmTable selectItems: (vmTable items select: [ :each | selection includes: each ])
]

{ #category : 'initialization' }
PhLVMPresenter >> rootCommandsGroup [ 
	^ rootCommandsGroup ifNil: [ rootCommandsGroup := super rootCommandsGroup ]
]

{ #category : 'api - selection' }
PhLVMPresenter >> selectAllVms [

	vmTable selectAll
]

{ #category : 'api - selection' }
PhLVMPresenter >> selectVm: aVm [

	vmTable selectItem: aVm
]

{ #category : 'accessing' }
PhLVMPresenter >> selectedVms [
	^ vmTable selectedItems
]

{ #category : 'updating' }
PhLVMPresenter >> showVersions: versionsByVmId updates: stampsByVmId [

	versions := versionsByVmId.
	publishedStamps := stampsByVmId.
	self refresh
]

{ #category : 'accessing' }
PhLVMPresenter >> statusFor: aVm [
	"Answer whether the VM is up to date, in words. The server is asked in background: until it answers, the status is being checked."

	aVm isUpdatable ifFalse: [ ^ aVm statusGivenPublishedStamp: nil ].
	PhLVmUpdateChecker shouldRun ifFalse: [ ^ '' ].
	publishedStamps ifNil: [ ^ 'Checking...' ].
	^ aVm statusGivenPublishedStamp: (self publishedStampOf: aVm)
]

{ #category : 'accessing' }
PhLVMPresenter >> statusDescriptionFor: aVm [
	"Answer the status of the VM, with the publication date of the update when one is available."

	| status |
	status := self statusFor: aVm.
	status = 'Update available' ifFalse: [ ^ status ].
	^ (self publishedStampOf: aVm) publicationDate
		  ifNil: [ status ]
		  ifNotNil: [ :date | status , ', published on ' , date yyyymmdd ]
]

{ #category : 'accessing' }
PhLVMPresenter >> versionDescriptionFor: aVm [

	^ self versions at: aVm id ifAbsent: [ '' ]
]

{ #category : 'private' }
PhLVMPresenter >> versions [

	^ versions ifNil: [ versions := Dictionary new ]
]

