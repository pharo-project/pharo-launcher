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
		'enableDevEnvironmentSwitch',
		'hardResetPersistentStateButton',
		'templateSourcesUrlInput',
		'sourcesFileLocationInput',
		'imagesLocationInput',
		'imagesInitScriptsLocationInput',
		'vmsLocationInput',
		'sourcesFileLocationButton',
		'imagesLocationButton',
		'imagesInitScriptsLocationButton',
		'vmsLocationButton'
	],
	#category : 'PharoLauncher-Spec2',
	#package : 'PharoLauncher-Spec2'
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
		spacing: 15;
		add: (SpBoxLayout newLeftToRight 
			add: 'Check for template sources update?';
			add: checkForTemplateSourcesUpdateSwitch expand: false;
			yourself) expand: false;
		add: (SpBoxLayout newLeftToRight 
			add: 'Templates cleared at startup';
			add: clearTemplatesSwitch expand: false;
			yourself) expand: false;
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
		add: (SpBoxLayout newLeftToRight 
			add: 'Enable development environment';
			add: enableDevEnvironmentSwitch expand: false;
			yourself) expand: false;
			
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
		add: hardResetPersistentStateButton expand: false;
		yourself
]

{ #category : 'initialization' }
PhLGeneralSettingsPresenter >> initializePresenters [

	clearTemplatesSwitch := self newCheckBoxFor: #templatesClearedOnStartup.
	quitOnLaunchSwitch := self newCheckBoxFor: #quitOnLaunch.
	launchFromALoginShellSwitch := self newCheckBoxFor: #launchInALoginShell .
	warnOnImageArchMisMatchSwitch := self newCheckBoxFor: #warnOnArchMismatch.
	checkForTemplateSourcesUpdateSwitch := self newCheckBoxFor: #shouldCheckTemplateSourcesUpdate.
	enableDevEnvironmentSwitch := self newCheckBoxFor: #developmentEnvironmentEnabled.

	templateSourcesUrlInput := self newTextInputFor: #sourcesUrl.
	sourcesFileLocationInput := (self newTextInputFor: #launcherCoreDirString)
		beNotEditable;
		yourself.
	sourcesFileLocationButton := self newButton
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor: sourcesFileLocationInput ];
		yourself.
	imagesLocationInput := self newTextInputFor: #locationString.
	imagesLocationButton := self newButton
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor: imagesLocationInput ];
		yourself.
	imagesInitScriptsLocationInput := self newTextInputFor: #initializationScriptsLocation.
	imagesInitScriptsLocationButton := self newButton
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor: imagesInitScriptsLocationInput ];
		yourself.
	vmsLocationInput := self newTextInputFor: #vmStoreString.
	vmsLocationButton := self newButton
		icon: (self iconNamed: #open);
		action: [ self chooseDirectoryFor:  vmsLocationInput ];
		yourself.
		
	hardResetPersistentStateButton := self newButton
		label: 'Hard reset persistent state'.
	
]
