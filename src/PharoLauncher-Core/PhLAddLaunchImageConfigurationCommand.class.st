Class {
	#name : #PhLAddLaunchImageConfigurationCommand,
	#superclass : #PhLImageCommand,
	#classVars : [
		'CommandAnnouncer',
		'QuitOnLaunch',
		'WarnOnArchMismatch'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> announceQuitOnLaunchValueChanged [
	self announcer announce: PhLQuitOnLaunchValueChanged
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> announcer [
	^ CommandAnnouncer ifNil: [ CommandAnnouncer := Announcer new ]
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> archMismatchSettingDescription [
	^ 'Get a warning when trying to launch an image with a different architecture than the Launcher (i.e. trying to launch a 32-bit image from Pharo Launcher 64-bit). '
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> archMismatchSettingLabel [
	^ 'Warn on image architecture mismatch? ' translated
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> group [
	^ 1
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> icon [

	^ self iconNamed: #configuration
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> quitOnLaunch [
	^ QuitOnLaunch ifNil: [  QuitOnLaunch := false ].
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> quitOnLaunch: aBoolean [
	| oldValue |
	oldValue := QuitOnLaunch.
	QuitOnLaunch := aBoolean.
	oldValue = QuitOnLaunch 
		ifFalse: [ CommandAnnouncer announce: PhLQuitOnLaunchValueChanged ]
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> settingsOn: aBuilder [
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

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand class >> title [
	^ 'Launch Configurations...'
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> warnOnArchMismatch [
	^ WarnOnArchMismatch ifNil: [  WarnOnArchMismatch := true ].
]

{ #category : #settings }
PhLAddLaunchImageConfigurationCommand class >> warnOnArchMismatch: aBoolean [
	WarnOnArchMismatch := aBoolean.

]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> execute [
	self model hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]
]

{ #category : #testing }
PhLAddLaunchImageConfigurationCommand >> isApplicable [
	^ self model hasSingleImageSelected or: [self model hasNoSelection ]
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> launchImage: aPhLImage [
	[ aPhLImage launchWithSettings: true ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> launchImageFromDisk [
	| imagePath |
	imagePath := UIManager default 
		chooseFullFileName: 'Open a Pharo image'
		extensions: #('image') 
		path: FileLocator home 
		preview: false.
	imagePath ifNil: [ ^ self ].
	imagePath asFileReference isFile ifFalse: [ ^self ].
	self launchImage: (PhLImageModel on: (PhLImage location: imagePath asFileReference))
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> launchSelectedImage [
	self launchImage: (PhLImageModel on: self model singleImage)
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand >> pharoStableImagePath [
	| img |
	img := (self resourcesPath  / 'images' / 'pharo-stable.zip') asFileReference.
	^ img exists 
		ifTrue: [ img ]
		ifFalse: [ nil ]
]

{ #category : #action }
PhLAddLaunchImageConfigurationCommand >> quit [
	(PhLQuitCommand on: self model) execute
]

{ #category : #accessing }
PhLAddLaunchImageConfigurationCommand >> resourcesPath [
	| vmDirectory |
	
	vmDirectory := Smalltalk vm binary parent.

	Smalltalk os isMacOSX ifTrue: [ ^ vmDirectory parent / 'Resources' ].
	Smalltalk os isUnix ifTrue: [ ^ vmDirectory parent/ 'shared' ].
	Smalltalk os isWindows ifTrue: [ ^ vmDirectory ].
]
