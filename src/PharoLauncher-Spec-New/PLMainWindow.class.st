Class {
	#name : #PLMainWindow,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'runButton',
		'imageTable'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLMainWindow class >> defaultSpec [

	^ SpecBoxLayout newVertical
			add: (SpecPanedLayout newHorizontal
				add: #imageTable);
			add: #runButton expand: false fill: false padding: 0;
			yourself
			
	
]

{ #category : #accessing }
PLMainWindow >> imageTable [
	
	^ imageTable
]

{ #category : #initialization }
PLMainWindow >> initializePresenter [

	super initializePresenter.
	imageTable whenSelectionChangedDo: [ :sel | runButton enabled: sel isEmpty not ]
]

{ #category : #initialization }
PLMainWindow >> initializeWidgets [

	runButton := self newButton
		label: 'Run';
		help: 'Runs the selected image.';
		enabled: false;
		yourself.
		
	imageTable := self newTable
		items: self model images;
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		addColumn: (StringTableColumn title: 'Architecture' evaluated: #arch);
		addColumn: (StringTableColumn title: 'Modified' evaluated: [:e | self readableDateFor: e lastModification]);
		yourself
]

{ #category : #initialization }
PLMainWindow >> initializeWindow: aWindow [

	aWindow title: 'Pharo Launcher'
]

{ #category : #formating }
PLMainWindow >> readableDateFor: aDateAndTime [ 
	
	^ PhLTimeUntilNowStrategy displayStringOf: aDateAndTime 
]

{ #category : #accessing }
PLMainWindow >> runButton [
	^ runButton
]
