"
A simple UI to show locally available Virtual Machines to launch Pharo images.
"
Class {
	#name : #PhLVMPresenterSpec1,
	#superclass : #ITBasicPresenter,
	#instVars : [
		'vmTable',
		'toolbar',
		'refreshBlock',
		'elementsBlock',
		'dataSource',
		'vmBlock',
		'privateVmsBlock'
	],
	#category : #'PharoLauncher-IceTray'
}

{ #category : #specs }
PhLVMPresenterSpec1 class >> defaultSpec [
	^ SpecLayout composed
		add: #vmTable;
		yourself
]

{ #category : #specs }
PhLVMPresenterSpec1 class >> example [
	<example>
	| vmBlock |
	vmBlock := [ PhLVirtualMachineManager new availableVirtualMachines 
		asSortedCollection: [ :vm1 :vm2 | vm1 name > vm2 name ] ].
	(self on: {vmBlock}) openWithSpec
]

{ #category : #'instance creation' }
PhLVMPresenterSpec1 class >> on: aDomainObject [
	| decorator |
	decorator := self basicNewWithOwner: nil.
	decorator decoree
		setModelBeforeInitialization: aDomainObject;
		initialize.	
	^ decorator
]

{ #category : #specs }
PhLVMPresenterSpec1 >> initialExtent [
	^ 520@300
]

{ #category : #initialization }
PhLVMPresenterSpec1 >> initializeToolbar [
	self toolbar
		addItem:
			(ITButton new
				label: 'update';
				icon: (self iconNamed: #smallUpdate);
				help: 'Update the virtual machine to the latest available version';
				action: [ self updateVms ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'show';
				icon: (self iconNamed: #smallOpen);
				help: 'Show the selected vm in its folder. Will open a system browser.';
				action: [ self showInFolder ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITButton new
				label: 'remove';
				icon: (self iconNamed: #smallDeleteIcon);
				help: 'Remove virtual machine';
				action: [ self removeVms ];
				yourself)
			position: ITItemPosition left;
		addItem:
			(ITToggleButton new
				label: 'private';
				icon: (self iconNamed: #smallLock);
				help: 'Show private VMs used to determine pharo version of an image!';
				beUnselected;
				action: [ :activated | self showPrivateVms: activated ];
				yourself)
			position: ITItemPosition right
]

{ #category : #initialization }
PhLVMPresenterSpec1 >> initializeWidgets [
	| lastUpdateColumn |
	
	self initializeToolbar.
	
	vmTable := self newSmartFastTable.
	vmTable widget
		add: #Name accessing: #name width: 50.
	lastUpdateColumn := vmTable widget 
		add: #'Last update' 
		display: [ :vm |
			| timestamp |
			timestamp := vm lastUpdateTime. 
			timestamp asDate yyyymmdd, ' ', timestamp asTime print24 
			].
	lastUpdateColumn width: 120.
	vmTable widget
		add: #'Download URL' accessing: #downloadUrl;
		intercellSpacing: 1;
		beMultipleSelection.
		
	self refresh.
	vmTable widget selectFirstVisibleRow.
]

{ #category : #initialization }
PhLVMPresenterSpec1 >> newSmartFastTable [
	^ FTSmartTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter
]

{ #category : #refreshing }
PhLVMPresenterSpec1 >> refresh [
	vmTable widget 
		elements: self virtualMachines;
		refresh.
]

{ #category : #actions }
PhLVMPresenterSpec1 >> removeVms [
	self selectedItems do: #removeFromSystem.
	self refresh.
]

{ #category : #selection }
PhLVMPresenterSpec1 >> selectedItems [
	^ vmTable widget selectedItems
]

{ #category : #initialization }
PhLVMPresenterSpec1 >> setModelBeforeInitialization: aDomainObject [
	vmBlock := aDomainObject first.
	privateVmsBlock := (aDomainObject size = 1)
		ifTrue: [ [ #() ] ]
		ifFalse: [ aDomainObject second ].
	elementsBlock := vmBlock.
]

{ #category : #actions }
PhLVMPresenterSpec1 >> showInFolder [
	| vms |
	vms := self selectedItems.
	vms size >= 1
		ifTrue: [ vms first showInFolder]
]

{ #category : #actions }
PhLVMPresenterSpec1 >> showPrivateVms: aBoolean [
	elementsBlock := aBoolean
		ifTrue: [ privateVmsBlock ]
		ifFalse: [ vmBlock ].
	self refresh
]

{ #category : #accessing }
PhLVMPresenterSpec1 >> title [
	^ 'Locally available Virtual Machines'
]

{ #category : #actions }
PhLVMPresenterSpec1 >> updateVms [
	self selectedItems do: #update.
	self refresh.
]

{ #category : #initialization }
PhLVMPresenterSpec1 >> virtualMachines [
	^ elementsBlock value
]

{ #category : #accessing }
PhLVMPresenterSpec1 >> vmTable [
	^ vmTable 
]
