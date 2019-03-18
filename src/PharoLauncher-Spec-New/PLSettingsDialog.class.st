Class {
	#name : #PLSettingsDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'messageLabel',
		'clearTemplatedCheckBox',
		'quitOnLaunchCheckBox',
		'launchOnLoginShellCheckBox',
		'warnOnArchMistmachCheckBox',
		'locationOfTemplates',
		'locationOfImages',
		'locationOfVMs',
		'hardResetCheckBox',
		'useHTTPProxyCheckBox',
		'checkForUpdatesCheckBox'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLSettingsDialog class >> defaultSpec [

	^ SpecGridLayout new
		beColumnNotHomogeneous;
		add: 'Use HTTP proxy' 							at: 1@1; add: #useHTTPProxyCheckBox 			at: 2@1;
		add: 'Templates cleared at startup' 			at: 1@2; add: #clearTemplatedCheckBox 		at: 2@2;
		add: 'Quit on launch' 							at: 1@3; add: #quitOnLaunchCheckBox 			at: 2@3;
		add: 'Launch image from a login shell' 		at: 1@4; add: #launchOnLoginShellCheckBox 	at: 2@4;
		add: 'Warn on image architecture mismatch'	at: 1@5; add: #warnOnArchMistmachCheckBox 	at: 2@5;
		add: 'Location of template sources file' 	at: 1@6; add: #locationOfTemplates 			at: 2@6;
		add: 'Location of your images' 				at: 1@7; add: #locationOfImages 				at: 2@7;
		add: 'Location of Virtual Machines' 			at: 1@8; add: #locationOfVMs 					at: 2@8;
		add: 'Check for template sources update' 	at: 1@9; add: #checkForUpdatesCheckBox 		at: 2@9;
		add: 'Hard reset persistance instance' 		at: 1@10; add: #hardResetCheckBox 			at: 2@10;
		yourself
]

{ #category : #actions }
PLSettingsDialog >> doAcceptThen: aBlock [

	self flag: #TODO. "Save the changes"
	aBlock value
]

{ #category : #initialization }
PLSettingsDialog >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter
		addButton: 'Cancel' do: #close;
		addButton: 'Accept' do: [ :presenter | 
			self doAcceptThen: [ 
				presenter beOk; close ] ]
]

{ #category : #initialization }
PLSettingsDialog >> initializeWidgets [
	
	useHTTPProxyCheckBox := self newCheckBox.
	clearTemplatedCheckBox := self newCheckBox.
	quitOnLaunchCheckBox := self newCheckBox.
	launchOnLoginShellCheckBox := self newCheckBox.
	warnOnArchMistmachCheckBox := self newCheckBox.
	locationOfTemplates := self newTextInput.
	locationOfImages := self newTextInput.
	locationOfVMs := self newTextInput.
	checkForUpdatesCheckBox := self newCheckBox.
	hardResetCheckBox  := self newCheckBox
]

{ #category : #initialization }
PLSettingsDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Settings';
		initialExtent: 800@300;
		centered
]
