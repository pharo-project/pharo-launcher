"
Pharo Launcher About dialog UI.

Example: 
	self example
"
Class {
	#name : #PhLAboutPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'description',
		'text',
		'iconName',
		'icon',
		'documentationLink'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLAboutPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #icon width: 90;
		add: 
			(SpBoxLayout newVertical
				spacing: 15;
				add: #description;
				add: #documentationLink expand: false;
			yourself);
		yourself
]

{ #category : #'instance creation' }
PhLAboutPresenter class >> example [
	| text |
	text := PhLAboutCommand new aboutText.
	
	(self text: text iconName: #pharo) openDialog
]

{ #category : #'instance creation' }
PhLAboutPresenter class >> text: aText iconName: anIconName [
	^ self new 
		text: aText;
		iconName: anIconName;
		yourself
]

{ #category : #specs }
PhLAboutPresenter class >> title [ 
	^ 'About'
]

{ #category : #accessing }
PhLAboutPresenter >> description [ 
	^ description
]

{ #category : #accessing }
PhLAboutPresenter >> icon [ 
	^ icon
]

{ #category : #accessing }
PhLAboutPresenter >> iconName: anIconName [
	iconName := anIconName
]

{ #category : #initialization }
PhLAboutPresenter >> initializeDialogWindow: aDialogWindow [
	self initializeWindow: aDialogWindow.
	aDialogWindow addButton: 'Ok'
		do: [ :presenter | presenter close ].
]

{ #category : #initialization }
PhLAboutPresenter >> initializePresenters [ 
	description := self newText.
	icon := self newImage.
	documentationLink := self newLink
		url: 'https://pharo-project.github.io/pharo-launcher';
		label: 'Open Pharo Launcher documentation (web)';
		yourself.

]

{ #category : #initialization }
PhLAboutPresenter >> initializeWindow: aWindow [
	description 
		text: text;
		disable.
   icon image: (self iconNamed: iconName).
]

{ #category : #accessing }
PhLAboutPresenter >> text: aText [
	text := aText
]
