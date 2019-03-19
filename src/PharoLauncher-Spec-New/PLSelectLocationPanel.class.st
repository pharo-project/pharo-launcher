Class {
	#name : #PLSelectLocationPanel,
	#superclass : #ComposablePresenter,
	#instVars : [
		'directoryText',
		'selectButton'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLSelectLocationPanel class >> defaultSpec [

	^ SpecBoxLayout newHorizontal
		spacing: 5;
		add: #directoryText;
		addLast: #selectButton expand: false fill: false padding: 0;
		yourself 
]

{ #category : #actions }
PLSelectLocationPanel >> doSelect [
	| directory |

	directory := self application selectDirectoryTitle: 'Select location...'.
	directory ifNil: [ ^ self ].
	
	directoryText text: directory fullName
]

{ #category : #initialization }
PLSelectLocationPanel >> initializeWidgets [

	directoryText := self newTextInput.
	selectButton := self newButton 
		icon: (self application iconNamed: #smallOpen);
		action: [ self doSelect ];
		yourself
]
