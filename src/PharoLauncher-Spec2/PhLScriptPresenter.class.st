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
		'saveButton'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #example }
PhLScriptPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add: #scriptTable
			withConstraints: [ :constraints | 
				constraints 
					spec: #withoutOrderingBar"; 
					width: 200" ];
		add: (SpBoxLayout newVertical
			add: #fileEditor;
			add: #saveButton expand: false;
			yourself);
		yourself
]

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
		openWithSpec;
		yourself
]

{ #category : #example }
PhLScriptPresenter class >> icebergLoadExample [
	^ 'Metacello new
  baseline: ''Tonel'';
  repository: ''github://pharo-vcs/tonel:v1.0.12'';
  load.'
]

{ #category : #initialization }
PhLScriptPresenter >> initializePresenters [ 
	scriptTable := (self instantiate: SpEditableList)
		items: self scripts;
		display: [ :file | file basename ];
		whenSelectionChangedDo: [ :selection | 
			fileEditor text: (selection isEmpty
				ifTrue: [ '' ]
				ifFalse: [ selection selectedItem contents ]) ];
		addItemBlock: [ self newScript ];
		removeItemBlock: [ :item | self removeScript: item ]
		yourself.
	fileEditor := self newCode
		autoAccept: true;
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

{ #category : #'instance creation' }
PhLScriptPresenter >> newScript [
	| newName |
	newName := self application newRequest
			title: 'New script name?';
			validateAnswer: [ :answer | (self scriptDirectory / answer) exists not ];
			request.
	newName ifNil: [ ^ nil ].
	
	^ (self scriptDirectory / newName) ensureCreateFile
]

{ #category : #action }
PhLScriptPresenter >> removeScript: aFileReference [ 
	
	aFileReference ifNil: [ ^ self ].
	(self application newConfirmation 
		message: 'Do you want to remove ', aFileReference fullName, ' script?';
		confirm) ifFalse: [ ^ self ].
		
	aFileReference ensureDelete.
	scriptTable	removeItem: aFileReference.
	scriptTable refresh.

]

{ #category : #action }
PhLScriptPresenter >> saveSelectedScript [
	| file |
	file := scriptTable selectedItem.
	file
		ensureDelete;
		writeStreamDo: [ :stream | stream nextPutAll: fileEditor text asString ]
]

{ #category : #accessing }
PhLScriptPresenter >> scriptDirectory [
	^ self model 
]

{ #category : #accessing }
PhLScriptPresenter >> scripts [
	^ self scriptDirectory files asSortedCollection 
]

{ #category : #action }
PhLScriptPresenter >> selectScript: aFileReference [
	^ scriptTable selectItem: aFileReference
]
