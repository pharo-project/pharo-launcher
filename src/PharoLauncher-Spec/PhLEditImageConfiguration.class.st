Class {
	#name : #PhLEditImageConfiguration,
	#superclass : #ComposablePresenter,
	#instVars : [
		'configurationTable',
		'selectedConfigurationNameLabel',
		'selectedConfigurationVMLabel',
		'selectedConfigurationNameField',
		'selectedConfigurationVMField',
		'image',
		'newConfigurationButton'
	],
	#category : #'PharoLauncher-Spec'
}

{ #category : #specs }
PhLEditImageConfiguration class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :row |
			row
				newColumn: #configurationTable width: 200;
				newColumn: [ :column | 
					column
						newRow: [ :fieldRow |
							fieldRow
								newColumn: #selectedConfigurationNameLabel width: 80;
								newColumn: #selectedConfigurationNameField ] height: 30;
						newRow: [ :fieldRow |
							fieldRow
								newColumn: #selectedConfigurationVMLabel width: 80;
								newColumn: #selectedConfigurationVMField ] height: 30;
						newRow: [ :x ];
						newRow: [ :buttons |
							buttons add: #newConfigurationButton ] height: 50 ];
				yourself ]
]

{ #category : #model }
PhLEditImageConfiguration >> addConfiguration [
	
	| configuration |
1haltOnce.
	configuration := image addConfiguration.
	self refresh.
	configurationTable widget selectRowIndex: (image configurations indexOf: configuration)
]

{ #category : #accessing }
PhLEditImageConfiguration >> configurationTable [
	^ configurationTable
]

{ #category : #accessing }
PhLEditImageConfiguration >> configurationTable: anObject [
	configurationTable := anObject
]

{ #category : #accessing }
PhLEditImageConfiguration >> image [
	^ image
]

{ #category : #api }
PhLEditImageConfiguration >> initialExtent [

	^ 800@400
]

{ #category : #initialization }
PhLEditImageConfiguration >> initializePresenter [
	
	self refresh.
	selectedConfigurationVMField items: { PhLDefaultVM image: image },(PhLVirtualMachineManager new virtualMachines).
	configurationTable widget selectFirstVisibleRow.

	selectedConfigurationVMField whenSelectedItemChanged: [ self updateConfigurationVM ].
]

{ #category : #initialization }
PhLEditImageConfiguration >> initializeWidgets [
	
	configurationTable := self newSmartFastTable.
	configurationTable widget add: #Name accessing: #name.
	configurationTable widget onAnnouncement: FTSelectionChanged send: #selectionChanged to: self.
		
	selectedConfigurationNameLabel := self newLabel.
	selectedConfigurationNameLabel label: 'Name'.
	selectedConfigurationNameField := self newTextInput.
	selectedConfigurationNameField autoAccept: true.
	selectedConfigurationNameField whenTextChanged: [ self updateConfigurationName ].
	
	selectedConfigurationVMLabel := self newLabel.
	selectedConfigurationVMLabel label: 'VM'.
	selectedConfigurationVMField := self newDropList.
	selectedConfigurationVMField displayBlock: [ :vm | vm name ].
	
	newConfigurationButton := self newButton.
	newConfigurationButton label: 'New'.
	newConfigurationButton action: [ self addConfiguration ].
]

{ #category : #accessing }
PhLEditImageConfiguration >> newConfigurationButton [
	^ newConfigurationButton
]

{ #category : #accessing }
PhLEditImageConfiguration >> newConfigurationButton: anObject [
	newConfigurationButton := anObject
]

{ #category : #initialization }
PhLEditImageConfiguration >> newSmartFastTable [

	^ FTSmartTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter
]

{ #category : #refreshing }
PhLEditImageConfiguration >> refresh [

	configurationTable widget 
		elements: image configurations;
		refresh.
]

{ #category : #events }
PhLEditImageConfiguration >> selectedConfiguration [

	^ configurationTable widget selectedItems anyOne
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationNameField [
	^ selectedConfigurationNameField
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationNameField: anObject [
	selectedConfigurationNameField := anObject
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationNameLabel [
	^ selectedConfigurationNameLabel
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationNameLabel: anObject [
	selectedConfigurationNameLabel := anObject
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationVMField [
	^ selectedConfigurationVMField
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationVMField: anObject [
	selectedConfigurationVMField := anObject
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationVMLabel [
	^ selectedConfigurationVMLabel
]

{ #category : #accessing }
PhLEditImageConfiguration >> selectedConfigurationVMLabel: anObject [
	selectedConfigurationVMLabel := anObject
]

{ #category : #events }
PhLEditImageConfiguration >> selectionChanged [

	| item |
	item := self selectedConfiguration.
	selectedConfigurationNameField text: item name.
	selectedConfigurationVMField setIndex: (selectedConfigurationVMField listItems indexOf: item vm).
]

{ #category : #'model access' }
PhLEditImageConfiguration >> setModelBeforeInitialization: anImage [

	image := anImage
]

{ #category : #model }
PhLEditImageConfiguration >> updateConfigurationName [
	
	self selectedConfiguration name: selectedConfigurationNameField text.
	self refresh.
]

{ #category : #model }
PhLEditImageConfiguration >> updateConfigurationVM [

	"there is no selection"
	selectedConfigurationVMField selectedIndex = 0 ifTrue: [ ^ self ].

	self selectedConfiguration vm: selectedConfigurationVMField selectedItem
]
