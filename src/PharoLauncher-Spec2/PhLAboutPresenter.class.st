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
		'icon'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #specs }
PhLAboutPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #icon width: 90;
		add: #description;
		yourself
]

{ #category : #'instance creation' }
PhLAboutPresenter class >> example [
	| text |
	text := String streamContents: [:stream |
		stream
			<< 'Pharo Launcher version: 2.0';
			cr; cr;
			<< 'Pharo Launcher is a tool that eases the management of Pharo images and their associated Virtual Machines. It can download official Pharo images from the Pharo repository, fetch the right virtual machine to run your image and many other things.';
			cr;
			<< 'If you find a bug, please open an issue at https://github.com/pharo-project/pharo-launcher/issues.'.
	].
	
	(self text: text iconName: #pharo) openDialogWithSpec
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
	description 
		text: text;
		disable.
   icon image: (self iconNamed: iconName).
	aDialogWindow addButton: 'Ok'
		do: [ :presenter | presenter close ].
]

{ #category : #initialization }
PhLAboutPresenter >> initializeWidgets [ 
	description := self newText.
	icon := self newImage.

]

{ #category : #accessing }
PhLAboutPresenter >> text: aText [
	text := aText
]
