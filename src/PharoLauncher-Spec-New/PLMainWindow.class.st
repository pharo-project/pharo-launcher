Class {
	#name : #PLMainWindow,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'runButton',
		'imageList'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLMainWindow class >> defaultSpec [

	^ SpecBoxLayout newVertical
			add: (SpecPanedLayout newHorizontal
				add: #imageList);
			add: #runButton expand: false fill: false padding: 0;
			yourself
			
	
]

{ #category : #accessing }
PLMainWindow >> imageList [
	
	^ imageList
]

{ #category : #initialization }
PLMainWindow >> initializePresenter [

	super initializePresenter.
	imageList whenSelectionChangedDo: [ :sel | runButton enabled: sel isEmpty not ]
]

{ #category : #initialization }
PLMainWindow >> initializeWidgets [

	runButton := self newButton
		label: 'Run';
		help: 'Runs the selected image.';
		enabled: false;
		yourself.
		
	imageList := self newList
		items: self model images;
		yourself
]

{ #category : #initialization }
PLMainWindow >> initializeWindow: aWindow [

	aWindow title: 'Pharo Launcher'
]

{ #category : #accessing }
PLMainWindow >> runButton [
	^ runButton
]
