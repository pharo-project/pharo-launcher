"
Launch the selected image with the appropriate virtual machine.
"
Class {
	#name : #PhLLaunchImageCommand2,
	#superclass : #PhLImageCommand2,
	#instVars : [
		'useSettings'
	],
	#classVars : [
		'QuitOnLaunch',
		'WarnOnArchMismatch'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #settings }
PhLLaunchImageCommand2 class >> archMismatchSettingDescription [
	^ 'Get a warning when trying to launch an image with a different architecture than the Launcher (i.e. trying to launch a 32-bit image from Pharo Launcher 64-bit). '
]

{ #category : #settings }
PhLLaunchImageCommand2 class >> archMismatchSettingLabel [
	^ 'Warn on image architecture mismatch? ' translated
]

{ #category : #settings }
PhLLaunchImageCommand2 class >> quitOnLaunch [
	^ QuitOnLaunch ifNil: [  QuitOnLaunch := false ].
]

{ #category : #settings }
PhLLaunchImageCommand2 class >> quitOnLaunch: aBoolean [
	QuitOnLaunch = aBoolean 
		ifFalse: [ QuitOnLaunch := aBoolean ]
]

{ #category : #settings }
PhLLaunchImageCommand2 class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #quitOnLaunch)
		label: 'Quit On Launch' translated;
		parent: #pharoLauncher;
		target: self;
		order: 30;
		description:
			'When enabled, Launcher quits when an image is launched. ' , String cr
				, 'When disabled, Launcher stays alive when an image is launched.'.
	(aBuilder setting: #warnOnArchMismatch)
		label: self archMismatchSettingLabel;
		parent: #pharoLauncher;
		target: self;
		order: 35;
		description: self archMismatchSettingDescription
]

{ #category : #settings }
PhLLaunchImageCommand2 class >> warnOnArchMismatch [
	^ WarnOnArchMismatch ifNil: [  WarnOnArchMismatch := true ].
]

{ #category : #settings }
PhLLaunchImageCommand2 class >> warnOnArchMismatch: aBoolean [
	WarnOnArchMismatch := aBoolean.

]

{ #category : #converting }
PhLLaunchImageCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallDoItIcon;
		shortcutKey: $l meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #converting }
PhLLaunchImageCommand2 >> asSpecLaunchWithoutSettingsCommand [
	self
		doNotUseSettings;
		basicName: 'Basic launch';
		basicDescription: 'Launch the selected Pharo image without settings'.

	^ super asSpecCommand
		iconName: #smallDoItIcon; "asGrayScaleWithAlpha"
		"shortcutKey: $l meta, $b meta ;"
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #accessing }
PhLLaunchImageCommand2 >> canBeRun [ 
	^ self imagesPresenter hasSingleImageSelected
]

{ #category : #configuring }
PhLLaunchImageCommand2 >> doNotUseSettings [
	useSettings := false.
]

{ #category : #executing }
PhLLaunchImageCommand2 >> execute [
	self imagesPresenter hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]
]

{ #category : #initialization }
PhLLaunchImageCommand2 >> initialize [
	super initialize.
	useSettings := true.
	self
		basicName: 'Launch';
		basicDescription: 'Launch the selected Pharo image'
]

{ #category : #executing }
PhLLaunchImageCommand2 >> launchImage: aPhLImage [
	[ aPhLImage launchWithSettings: useSettings ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]
]

{ #category : #executing }
PhLLaunchImageCommand2 >> launchSelectedImage [
	self launchImage: self imagesPresenter singleImage
]

{ #category : #private }
PhLLaunchImageCommand2 >> quit [
	(PhLQuitCommand2 forSpec context: self imagesPresenter) execute
]
