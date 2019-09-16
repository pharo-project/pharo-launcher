"
I am a presenter to edit launcher configurations.
Each image in the pharo launcher has many configurations to run (vm, arguments...) and I list and edit them.
"
Class {
	#name : #PhLEditImageConfigurationPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'configurationTable',
		'selectedConfigurationNameLabel',
		'selectedConfigurationVMLabel',
		'selectedConfigurationNameField',
		'selectedConfigurationVMField',
		'image',
		'newConfigurationButton',
		'saveConfigurationButton',
		'deleteConfigurationButton',
		'selectedConfigurationImageArgumentsLabel',
		'selectedConfigurationImageArgumentsField'
	],
	#category : #'PharoLauncher-Spec'
}

{ #category : #specs }
PhLEditImageConfigurationPresenter class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :row |
			row
				newColumn: #configurationTable width: 200;
				newColumn: [ :column | 
					column
						newRow: [ :fieldRow |
							fieldRow
								newColumn: #selectedConfigurationNameLabel width: 100;
								newColumn: #selectedConfigurationNameField ] height: 30;
						newRow: [ :fieldRow |
							fieldRow
								newColumn: #selectedConfigurationVMLabel width: 100;
								newColumn: #selectedConfigurationVMField ] height: 30;
						newRow: [ :fieldRow |
							fieldRow
								newColumn: #selectedConfigurationImageArgumentsLabel width: 100;
								newColumn: #selectedConfigurationImageArgumentsField ] height: 30;
						newRow: [ :x ];
						newRow: [ :buttons |
							buttons newColumn: [ :empty ].
							buttons add: #newConfigurationButton.
							buttons add: #deleteConfigurationButton.
							buttons add: #saveConfigurationButton ] height: 50 ];
				yourself ]
]

{ #category : #model }
PhLEditImageConfigurationPresenter >> addConfiguration [
	
	| configuration |
	configuration := image addConfiguration.
	self refresh.
	configurationTable widget selectRowIndex: (image configurations indexOf: configuration)
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> configurationTable [
	^ configurationTable
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> configurationTable: anObject [
	configurationTable := anObject
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> deleteConfigurationButton [
	^ deleteConfigurationButton
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> deleteConfigurationButton: anObject [
	deleteConfigurationButton := anObject
]

{ #category : #model }
PhLEditImageConfigurationPresenter >> deleteSelectedConfiguration [
	
	self selectedConfiguration ifNil: [ ^ self ].

	image removeConfiguration: self selectedConfiguration.
	configurationTable widget selectRowIndex: 0.
	self refresh.
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> image [
	^ image
]

{ #category : #api }
PhLEditImageConfigurationPresenter >> initialExtent [

	^ 800@400
]

{ #category : #initialization }
PhLEditImageConfigurationPresenter >> initializePresenter [
	
	self refresh.
	selectedConfigurationVMField items: { PhLDefaultVM image: image },(PhLVirtualMachineManager new virtualMachines).
	configurationTable widget selectFirstVisibleRow.

	selectedConfigurationVMField whenSelectedItemChanged: [ self updateConfigurationVM ].
]

{ #category : #initialization }
PhLEditImageConfigurationPresenter >> initializeWidgets [
	
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

	selectedConfigurationImageArgumentsLabel := self newLabel.
	selectedConfigurationImageArgumentsLabel label: 'Image Arguments'.
	selectedConfigurationImageArgumentsField := self newTextInput.
	selectedConfigurationImageArgumentsField autoAccept: true.
	selectedConfigurationImageArgumentsField whenTextChanged: [ self updateImageArguments ].
	
	newConfigurationButton := self newButton.
	newConfigurationButton label: 'New'.
	newConfigurationButton action: [ self addConfiguration ].
	
	saveConfigurationButton := self newButton.
	saveConfigurationButton label: 'Save'.
	saveConfigurationButton action: [ self saveConfiguration ].
	
	deleteConfigurationButton := self newButton.
	deleteConfigurationButton label: 'Delete'.
	deleteConfigurationButton action: [ self deleteSelectedConfiguration ].
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> newConfigurationButton [
	^ newConfigurationButton
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> newConfigurationButton: anObject [
	newConfigurationButton := anObject
]

{ #category : #initialization }
PhLEditImageConfigurationPresenter >> newSmartFastTable [

	^ FTSmartTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter
]

{ #category : #refreshing }
PhLEditImageConfigurationPresenter >> refresh [

	configurationTable widget 
		elements: image configurations;
		refresh.
	self refreshDeleteButton.

]

{ #category : #events }
PhLEditImageConfigurationPresenter >> refreshDeleteButton [

	| item |
	item := self selectedConfiguration.
	deleteConfigurationButton
		enabled: (item notNil and: [ image configurations size > 1 ])
]

{ #category : #model }
PhLEditImageConfigurationPresenter >> saveConfiguration [
	
	image saveConfigurations
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> saveConfigurationButton [
	^ saveConfigurationButton
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> saveConfigurationButton: anObject [
	saveConfigurationButton := anObject
]

{ #category : #events }
PhLEditImageConfigurationPresenter >> selectedConfiguration [

	configurationTable widget selectedItems ifEmpty: [ ^ nil ].
	^ configurationTable widget selectedItems anyOne
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationImageArgumentsField [
	^ selectedConfigurationImageArgumentsField
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationImageArgumentsField: anObject [
	selectedConfigurationImageArgumentsField := anObject
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationImageArgumentsLabel [
	^ selectedConfigurationImageArgumentsLabel
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationImageArgumentsLabel: anObject [
	selectedConfigurationImageArgumentsLabel := anObject
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationNameField [
	^ selectedConfigurationNameField
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationNameField: anObject [
	selectedConfigurationNameField := anObject
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationNameLabel [
	^ selectedConfigurationNameLabel
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationNameLabel: anObject [
	selectedConfigurationNameLabel := anObject
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationVMField [
	^ selectedConfigurationVMField
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationVMField: anObject [
	selectedConfigurationVMField := anObject
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationVMLabel [
	^ selectedConfigurationVMLabel
]

{ #category : #accessing }
PhLEditImageConfigurationPresenter >> selectedConfigurationVMLabel: anObject [
	selectedConfigurationVMLabel := anObject
]

{ #category : #events }
PhLEditImageConfigurationPresenter >> selectionChanged [

	| item |
	item := self selectedConfiguration.
	selectedConfigurationNameField enabled: item notNil.
	selectedConfigurationVMField enabled: item notNil.
	selectedConfigurationImageArgumentsField enabled: item notNil.
	self refreshDeleteButton.
	
	item ifNil: [ 
		selectedConfigurationNameField text: ''.
		selectedConfigurationVMField setIndex: 0.
		selectedConfigurationImageArgumentsField text: ''.
		^ self
	].
	
	selectedConfigurationNameField text: item name.
	selectedConfigurationVMField setIndex: (selectedConfigurationVMField listItems indexOf: item vm).
	selectedConfigurationImageArgumentsField text: item imageArguments.
]

{ #category : #'model access' }
PhLEditImageConfigurationPresenter >> setModelBeforeInitialization: anImage [

	image := anImage
]

{ #category : #model }
PhLEditImageConfigurationPresenter >> updateConfigurationName [
	
	self selectedConfiguration ifNil: [ ^ self ].
	
	self selectedConfiguration name: selectedConfigurationNameField text.
	self refresh.
]

{ #category : #model }
PhLEditImageConfigurationPresenter >> updateConfigurationVM [

	"there is no selection"
	self selectedConfiguration ifNil: [ ^ self ].
	selectedConfigurationVMField selectedIndex = 0 ifTrue: [ ^ self ].

	self selectedConfiguration vm: selectedConfigurationVMField selectedItem
]

{ #category : #model }
PhLEditImageConfigurationPresenter >> updateImageArguments [
	
	self selectedConfiguration imageArguments: selectedConfigurationImageArgumentsField text
]
