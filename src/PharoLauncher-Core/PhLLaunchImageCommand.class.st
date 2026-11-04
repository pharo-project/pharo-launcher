"
Launch the selected image with the appropriate virtual machine.
"
Class {
	#name : 'PhLLaunchImageCommand',
	#superclass : 'PhLImageCommand',
	#instVars : [
		'useSettings'
	],
	#classVars : [
		'QuitOnLaunch',
		'WarnOnArchMismatch'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'settings' }
PhLLaunchImageCommand class >> archMismatchSettingDescription [
	^ 'Get a warning when trying to launch an image with a different architecture than the Launcher (i.e. trying to launch a 32-bit image from Pharo Launcher 64-bit). '
]

{ #category : 'settings' }
PhLLaunchImageCommand class >> archMismatchSettingLabel [
	^ 'Warn on image architecture mismatch? ' translated
]

{ #category : 'settings' }
PhLLaunchImageCommand class >> quitOnLaunch [
	^ QuitOnLaunch ifNil: [  QuitOnLaunch := false ].
]

{ #category : 'settings' }
PhLLaunchImageCommand class >> quitOnLaunch: aBoolean [
	QuitOnLaunch = aBoolean 
		ifFalse: [ QuitOnLaunch := aBoolean ]
]

{ #category : 'settings' }
PhLLaunchImageCommand class >> settingsOn: aBuilder [

	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #quitOnLaunch)
		label: 'Quit On Launch' translated;
		groupName: #pharoLauncher;
		target: self;
		order: 30;
		description:
			'When enabled, Launcher quits when an image is launched. '
			, String cr
			, 'When disabled, Launcher stays alive when an image is launched.'.
	(aBuilder setting: #warnOnArchMismatch)
		label: self archMismatchSettingLabel;
		groupName: #pharoLauncher;
		target: self;
		order: 35;
		description: self archMismatchSettingDescription
]

{ #category : 'settings' }
PhLLaunchImageCommand class >> warnOnArchMismatch [
	^ WarnOnArchMismatch ifNil: [  WarnOnArchMismatch := true ].
]

{ #category : 'settings' }
PhLLaunchImageCommand class >> warnOnArchMismatch: aBoolean [
	WarnOnArchMismatch := aBoolean.

]

{ #category : 'converting' }
PhLLaunchImageCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDoIt;
		shortcutKey: $l actionModifier;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : 'converting' }
PhLLaunchImageCommand >> asSpecLaunchWithoutSettingsCommand [

	self
		doNotUseSettings;
		name: 'Basic launch';
		description: 'Launch the selected Pharo image without settings'.
	
	^ super asSpecCommand
		iconProvider: self;
		iconName: #smallDoIt;
		shortcutKey: $l shift actionModifier;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : 'private' }
PhLLaunchImageCommand >> basicIconNamed: aName [
	"Only used for basic launch command"
	^ super iconNamed: aName
]

{ #category : 'private' }
PhLLaunchImageCommand >> shouldContinueAfter: aWarning [

	self class warnOnArchMismatch ifFalse: [ ^ true ].

	^ self imagesPresenter newConfirmation
		title: aWarning name;
		message: aWarning longDescription;
		confirm
]

{ #category : 'private' }
PhLLaunchImageCommand >> showError: anError [

	self imagesPresenter newInformation
		title: anError name;
		message: anError longDescription;
		inform
]

{ #category : 'configuring' }
PhLLaunchImageCommand >> doNotUseSettings [
	useSettings := false.
]

{ #category : 'executing' }
PhLLaunchImageCommand >> execute [

	self imagesPresenter hasSingleImageSelected
		ifTrue: [ ^ self launchSelectedImage ]
		ifFalse: [ ^ nil ]
]

{ #category : 'private' }
PhLLaunchImageCommand >> iconNamed: aName [
	"Only used for basic launch command"
	^ (self basicIconNamed: aName) asGrayScaleWithAlpha
]

{ #category : 'initialization' }
PhLLaunchImageCommand >> initialize [
	super initialize.
	useSettings := true.
	self name: 'Launch'
]

{ #category : 'executing' }
PhLLaunchImageCommand >> launchConfigurationOfImage: aPhLImage [
	^ self imagesPresenter selectedLaunchConfiguration
]

{ #category : 'executing' }
PhLLaunchImageCommand >> launchImage: aPhLImage [
	| process launchConfig confirmed |

	self imagesPresenter ensurePharoVersionFor: aPhLImage.
	confirmed := false.
	[  [ launchConfig := self launchConfigurationOfImage: aPhLImage.
		  launchConfig useSettings: useSettings.
		  process := aPhLImage launchWithConfiguration: launchConfig ]
		on: PhLArchitectureMismatchWarning
		do: [ :warning |
			confirmed ifFalse: [ "only raise one warning"
				(self shouldContinueAfter: warning) ifFalse: [ ^ nil ].
				confirmed := true ].
			warning resume ] ]
	on: PhLError
	do: [ :error | self showError: error. ^ process ].
	"Waiting for https://github.com/pharo-contributions/OSSubprocess/issues/58 to be fixed
	(PhLLaunchedImagesWatcher process: process image: aPhLImage) check."
	self class quitOnLaunch
		ifTrue: [ self quit ].
	^ process
]

{ #category : 'executing' }
PhLLaunchImageCommand >> launchSelectedImage [

	^ self launchImage: self imagesPresenter singleImage
]

{ #category : 'private' }
PhLLaunchImageCommand >> quit [
	(PhLQuitCommand forSpecContext: self imagesPresenter) execute
]
