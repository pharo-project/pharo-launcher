"
I allow to edit settings related to Pharo Launcher
"
Class {
	#name : 'PhLGeneralSettingsPresenter',
	#superclass : 'PhLAbstractSettingsPresenter',
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'clearTemplatesSwitch',
		'quitOnLaunchSwitch',
		'launchFromALoginShellSwitch',
		'warnOnImageArchMisMatchSwitch',
		'checkForTemplateSourcesUpdateSwitch',
		'hardResetPersistentStateButton',
		'templateSourcesUrlInput',
		'sourcesFileLocationInput',
		'imagesLocationInput',
		'imagesInitScriptsLocationInput',
		'vmsLocationInput',
		'sourcesFileLocationButton',
		'imagesLocationButton',
		'imagesInitScriptsLocationButton',
		'vmsLocationButton',
		'forceSourcesUpdateButton'
	],
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'instance creation' }
PhLGeneralSettingsPresenter class >> open [
<script> 

	^ (self on: PharoLauncherSettings new) open
]

{ #category : 'initialization' }
PhLGeneralSettingsPresenter >> chooseDirectoryFor: anInputTextPresenter [
	
	| directory |
	directory := self newFileRequest
			currentFolder: FileLocator launcherUserFilesLocation;
			chooseDirectory.
	directory ifNil: [ ^ self ].
	
	anInputTextPresenter text: directory asFileReference fullName
]

{ #category : 'layout' }
PhLGeneralSettingsPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: self newSourcesSection;
		add: self newGeneralSection;
		add: self newLocationsSection;
		add: self newResetSection expand: false;
		yourself
]

{ #category : 'private' }
PhLGeneralSettingsPresenter >> forceTemplateSourcesUpdate [

	PhLPharoTemplateSources fromFile forceTemplateSourcesUpdate
]

{ #category : 'initialization' }
PhLGeneralSettingsPresenter >> initializePresenters [

	self addStyle: 'settings_form'.

	clearTemplatesSwitch := self newSwitchFor: #templatesClearedOnStartup.
	quitOnLaunchSwitch := self newSwitchFor: #quitOnLaunch.
	launchFromALoginShellSwitch := self newSwitchFor: #launchInALoginShell .
	warnOnImageArchMisMatchSwitch := self newSwitchFor: #warnOnArchMismatch.
	checkForTemplateSourcesUpdateSwitch := self newSwitchFor: #shouldCheckTemplateSourcesUpdate.

	templateSourcesUrlInput := self newTextInputFor: #sourcesUrl.
	sourcesFileLocationInput := (self newTextInputFor: #launcherCoreDirString)
		beNotEditable;
		yourself.
	sourcesFileLocationButton := self newButton
		addStyle: 'flat';
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor: sourcesFileLocationInput ];
		yourself.
	forceSourcesUpdateButton := self newButton
		label: 'Force template sources update';
		action: [ self forceTemplateSourcesUpdate ];
		yourself.

	imagesLocationInput := self newTextInputFor: #locationString.
	imagesLocationButton := self newButton
		addStyle: 'flat';
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor: imagesLocationInput ];
		yourself.
	imagesInitScriptsLocationInput := self newTextInputFor: #initializationScriptsLocation.
	imagesInitScriptsLocationButton := self newButton
		addStyle: 'flat';
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor: imagesInitScriptsLocationInput ];
		yourself.
	vmsLocationInput := self newTextInputFor: #vmStoreString.
	vmsLocationButton := self newButton
		addStyle: 'flat';
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor:  vmsLocationInput ];
		yourself.
		
	hardResetPersistentStateButton := self newButton
		label: 'Hard reset persistent state'.
	
]

{ #category : 'layout' }
PhLGeneralSettingsPresenter >> newGeneralSection [
		
	^ self newPresenter 
		addStyle: 'section';
		layout: (SpBoxLayout newTopToBottom 
			add: (SpBoxLayout newLeftToRight 
				add: 'Quit On Launch';
				add: quitOnLaunchSwitch expand: false;
				yourself) expand: false;
			add: (SpBoxLayout newLeftToRight 
				add: 'Launch image from a login shell';
				add: launchFromALoginShellSwitch expand: false;
				yourself) expand: false;
			add: (SpBoxLayout newLeftToRight 
				add: 'Warn on image architecture mismatch?';
				add: warnOnImageArchMisMatchSwitch expand: false;
				yourself) expand: false;
			yourself);
		yourself
]

{ #category : 'layout' }
PhLGeneralSettingsPresenter >> newLocationsSection [
		
	^ self newPresenter
		addStyle: 'section';
		layout: (SpBoxLayout newTopToBottom
			add: 'Template sources Url' expand: false;
			add: (SpBoxLayout newLeftToRight 
				add: templateSourcesUrlInput;
				yourself) expand: false;
			add: 'Location of template sources file' expand: false;
			add: (SpBoxLayout newLeftToRight 
				spacing: 5; 
				add: sourcesFileLocationInput;
				add: sourcesFileLocationButton expand: false;
				yourself) expand: false;
			add: 'Location of your images' expand: false;
			add: (SpBoxLayout newLeftToRight 
				spacing: 5; 
				add: imagesLocationInput;
				add: imagesLocationButton expand: false;
				yourself) expand: false;
			add: 'Location of your image initialization scripts' expand: false;
			add: (SpBoxLayout newLeftToRight
				spacing: 5; 
				add: imagesInitScriptsLocationInput;
				add: imagesInitScriptsLocationButton expand: false;
				yourself) expand: false;
			add: 'VMs Directory' expand: false;
			add: (SpBoxLayout newLeftToRight 
				spacing: 5; 
				add: vmsLocationInput;
				add: vmsLocationButton expand: false;
				yourself) expand: false;
			yourself);
		yourself
]

{ #category : 'layout' }
PhLGeneralSettingsPresenter >> newResetSection [

	^ self newPresenter 
		addStyle: 'section';
		layout: (SpBoxLayout newTopToBottom
			add: hardResetPersistentStateButton expand: false;
			yourself);
		yourself
]

{ #category : 'layout' }
PhLGeneralSettingsPresenter >> newSection: aString [

	^ self newLabel 
		addStyle: 'header';
		label: aString;
		yourself
]

{ #category : 'layout' }
PhLGeneralSettingsPresenter >> newSourcesSection [

	^ self newPresenter 
		addStyle: 'section';
		layout: (SpBoxLayout newTopToBottom 
			add: (SpBoxLayout newLeftToRight
				add: 'Check for template sources update?';
				add: checkForTemplateSourcesUpdateSwitch expand: false;
				yourself) expand: false;
			add: (SpBoxLayout newLeftToRight 
				add: 'Templates cleared at startup';
				add: clearTemplatesSwitch expand: false;
				yourself) expand: false;
			add: forceSourcesUpdateButton expand: false;
			yourself);
		yourself
]
