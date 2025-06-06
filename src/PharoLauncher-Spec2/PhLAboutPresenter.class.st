"
Pharo Launcher About dialog UI.

Example: 
	self example
"
Class {
	#name : 'PhLAboutPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'description',
		'text',
		'iconName',
		'icon',
		'documentationLink'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'instance creation' }
PhLAboutPresenter class >> example [
	| text |
	text := PhLAboutCommand new aboutText.
	
	(self text: text iconName: #pharo) openDialog
]

{ #category : 'instance creation' }
PhLAboutPresenter class >> text: aText iconName: anIconName [

	^ self new 
		text: aText;
		iconName: anIconName;
		yourself
]

{ #category : 'specs' }
PhLAboutPresenter class >> title [ 
	^ 'About'
]

{ #category : 'layout' }
PhLAboutPresenter >> defaultLayout [

	^ SpBoxLayout newHorizontal
		borderWidth: 10;
		add: icon;
		add: (SpBoxLayout newVertical
				spacing: 15;
				add: description;
				add: documentationLink expand: false;
			yourself);
		yourself
]

{ #category : 'accessing' }
PhLAboutPresenter >> description [ 
	^ description
]

{ #category : 'accessing' }
PhLAboutPresenter >> icon [ 
	^ icon
]

{ #category : 'accessing' }
PhLAboutPresenter >> iconName: anIconName [

	iconName := anIconName.
	self updatePresenter
]

{ #category : 'initialization' }
PhLAboutPresenter >> initialExtent [

	^ 680@440
]

{ #category : 'initialization' }
PhLAboutPresenter >> initialize [

	iconName := #pharoBig.
	super initialize
]

{ #category : 'initialization' }
PhLAboutPresenter >> initializeDialogWindow: aDialogWindow [
	self initializeWindow: aDialogWindow.
	aDialogWindow addButton: 'Ok'
		do: [ :presenter | presenter close ].
]

{ #category : 'initialization' }
PhLAboutPresenter >> initializePresenters [
 
	description := self newText.
	icon := self newImage
		addStyle: 'aboutIcon';
		yourself.
	documentationLink := self newLink
		url: 'https://pharo-project.github.io/pharo-launcher';
		label: 'Open Pharo Launcher documentation (web)';
		yourself.

]

{ #category : 'initialization' }
PhLAboutPresenter >> initializeWindow: aWindow [
	
	aWindow title: 'About Pharo Launcher'.
	aWindow initialExtent: self initialExtent
]

{ #category : 'accessing' }
PhLAboutPresenter >> text: aText [

	text := aText.
	self updatePresenter
]

{ #category : 'initialization' }
PhLAboutPresenter >> updatePresenter [ 

	description 
		text: text;
		editable: false.
   icon image: (self iconNamed: iconName)
]
