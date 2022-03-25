"
I present a list of scripts and allow to edit, remove or add a new script.
"
Class {
	#name : #PhLScriptPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'scriptTable',
		'fileEditor',
		'saveButton',
		'scriptListChangedBlock'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #example }
PhLScriptPresenter class >> example [
	| fs |
	fs := FileSystem memory.
	fs root / 'loadSpec.st'
		writeStreamDo: [ :s | s nextPutAll: 'Metacello new
    baseline: ''Iceberg'';
    repository: ''filetree://./'';
    load.' ].
	fs root / 'icebergLoadExample.st'
		writeStreamDo: [ :s | s nextPutAll: self icebergLoadExample ].
	^ (self newApplication: PharoLauncherApplication new 
		model: fs root) 
		open;
		yourself
]

{ #category : #example }
PhLScriptPresenter class >> icebergLoadExample [
	^ 'Metacello new
  baseline: ''Tonel'';
  repository: ''github://pharo-vcs/tonel:v1.0.12'';
  load.'
]

{ #category : #layout }
PhLScriptPresenter >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 30 percent;
		  add: scriptTable withConstraints: [ :constraints | 
			  constraints spec: #withoutOrderingBar ];
		  add: (SpBoxLayout newVertical
				   add: fileEditor;
				   add: saveButton expand: false;
				   yourself);
		  yourself
]

{ #category : #'user interaction' }
PhLScriptPresenter >> defaultSaveShortCut [
	^ $s command mac | $s ctrl win | $s ctrl unix
]

{ #category : #initialization }
PhLScriptPresenter >> initializePresenters [ 
	scriptTable := (self instantiate: SpEditableListPresenter)
		items: self scripts;
		display: [ :file | file basename ];
		whenSelectionChangedDo: [ :selection | 
			selection isEmpty
				ifTrue: [ fileEditor 
								text: '' ;
								disable. ]
				ifFalse: [ fileEditor 
								text: selection selectedItem contents;
								enable. ] ];
		addItemBlock: [ self newScript ];
		removeItemBlock: [ :item | self removeScript: item ]
		yourself.
	fileEditor := self newCode
		disable;
		yourself.
	saveButton := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave);
		action: [ self saveSelectedScript ];
		yourself.
]

{ #category : #initialization }
PhLScriptPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Available initialization scripts';
		initialExtent: 800@550.
]

{ #category : #action }
PhLScriptPresenter >> newScript [
	| newName |
	
	newName := self application newRequest
			title: 'New script name?';
			validateAnswer: [ :answer | (self scriptDirectory / answer) exists not ];
			request.
	
	^ self newScriptNamed: newName
]

{ #category : #action }
PhLScriptPresenter >> newScriptNamed: aName [
	| file |
	aName ifNil: [ ^ nil ].
	
	file := self scriptDirectory / aName.
	file extension = 'st'
		ifFalse: [ file := file, 'st' ].
	file ensureCreateFile.
	self scriptListChanged.
	^ file
]

{ #category : #action }
PhLScriptPresenter >> removeScript: aFileReference [ 
	
	aFileReference ifNil: [ ^ self ].
	(self application newConfirmation
		parentWindow: self window;
		message: 'Do you want to remove ', aFileReference fullName, ' script?';
		confirm) 
		ifFalse: [ ^ self ].
		
	aFileReference ensureDelete.
	scriptTable	removeItem: aFileReference.
	self scriptListChanged
]

{ #category : #action }
PhLScriptPresenter >> saveSelectedScript [
	| file |
	file := scriptTable selectedItem.
	file ifNil: [ ^ self application newInformation
		message: 'Cannot save: no script selected!';
		inform ].
	file
		ensureDelete;
		writeStreamDo: [ :stream | stream nextPutAll: fileEditor text asString ]
]

{ #category : #accessing }
PhLScriptPresenter >> scriptDirectory [
	^ self model 
]

{ #category : #action }
PhLScriptPresenter >> scriptListChanged [
	scriptTable refresh.
	scriptListChangedBlock ifNotNil: [ scriptListChangedBlock cull: self ].
]

{ #category : #accessing }
PhLScriptPresenter >> scripts [
	^ (self scriptDirectory files 
		select: [ :file | file extension = 'st' ])
			asSortedCollection 
]

{ #category : #action }
PhLScriptPresenter >> selectScript: aFileReference [
	^ scriptTable selectItem: aFileReference
]

{ #category : #events }
PhLScriptPresenter >> whenScriptListChanged: aBlock [ 
	scriptListChangedBlock := aBlock.
]
