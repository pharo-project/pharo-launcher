"
Uses the current VirtualMachine to launch the selected image.
"
Class {
	#name : #PhLLaunchImageCommand,
	#superclass : #PhLImageCommand,
	#instVars : [
		'launchConfiguration'
	],
	#classVars : [
		'CommandAnnouncer',
		'QuitOnLaunch',
		'WarnOnArchMismatch'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLLaunchImageCommand class >> announceQuitOnLaunchValueChanged [
	self announcer announce: PhLQuitOnLaunchValueChanged
]

{ #category : #accessing }
PhLLaunchImageCommand class >> announcer [
	^ CommandAnnouncer ifNil: [ CommandAnnouncer := Announcer new ]
]

{ #category : #settings }
PhLLaunchImageCommand class >> archMismatchSettingDescription [
	^ 'Get a warning when trying to launch an image with a different architecture than the Launcher (i.e. trying to launch a 32-bit image from Pharo Launcher 64-bit). '
]

{ #category : #settings }
PhLLaunchImageCommand class >> archMismatchSettingLabel [
	^ 'Warn on image architecture mismatch? ' translated
]

{ #category : #accessing }
PhLLaunchImageCommand class >> group [
	^ 1
]

{ #category : #accessing }
PhLLaunchImageCommand class >> icon [
	^ self iconNamed: #smallDoItIcon
]

{ #category : #settings }
PhLLaunchImageCommand class >> quitOnLaunch [
	^ QuitOnLaunch ifNil: [  QuitOnLaunch := false ].
]

{ #category : #settings }
PhLLaunchImageCommand class >> quitOnLaunch: aBoolean [
	| oldValue |
	oldValue := QuitOnLaunch.
	QuitOnLaunch := aBoolean.
	oldValue = QuitOnLaunch 
		ifFalse: [ CommandAnnouncer announce: PhLQuitOnLaunchValueChanged ]
]

{ #category : #settings }
PhLLaunchImageCommand class >> settingsOn: aBuilder [
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
PhLLaunchImageCommand class >> title [
	^ 'Launch'
]

{ #category : #settings }
PhLLaunchImageCommand class >> warnOnArchMismatch [
	^ WarnOnArchMismatch ifNil: [  WarnOnArchMismatch := true ].
]

{ #category : #settings }
PhLLaunchImageCommand class >> warnOnArchMismatch: aBoolean [
	WarnOnArchMismatch := aBoolean.

]

{ #category : #action }
PhLLaunchImageCommand >> asBasicMenuItem [
	^ super asMenuItem
]

{ #category : #action }
PhLLaunchImageCommand >> asMenuItem [
	^ MenuItemPresenter new
		name: self title;
		action: [ self validateModelIntegrity
				ifTrue: [ self execute ] ];
		icon: self icon;
		enabled: self isApplicable;
		subMenu: (MenuPresenter new addGroup: [ :group |
			self model singleImage launchConfigurations do: [ :each |
				group addMenuItem: (PhLLaunchImageCommand new
					setModel: model;
					launchConfiguration: each;
					asBasicMenuItem).
				].
			group
				addMenuItem: (PhLAddLaunchImageConfigurationCommand new
					setModel: model;
					asMenuItem) ])
]

{ #category : #action }
PhLLaunchImageCommand >> execute [
	self model hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]
]

{ #category : #initialization }
PhLLaunchImageCommand >> initialize [

	super initialize.
	launchConfiguration := PhlLaunchConfiguration default
]

{ #category : #testing }
PhLLaunchImageCommand >> isApplicable [
	^ self model hasSingleImageSelected or: [self model hasNoSelection ]
]

{ #category : #accessing }
PhLLaunchImageCommand >> launchConfiguration: aPhlLaunchConfiguration [

	launchConfiguration := aPhlLaunchConfiguration
]

{ #category : #action }
PhLLaunchImageCommand >> launchImage: aPhLImage [
	[ aPhLImage launchWithConfiguration: launchConfiguration ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]
]

{ #category : #action }
PhLLaunchImageCommand >> launchImageFromDisk [
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
PhLLaunchImageCommand >> launchSelectedImage [
	self launchImage: (PhLImageModel on: self model singleImage)
]

{ #category : #accessing }
PhLLaunchImageCommand >> pharoStableImagePath [
	| img |
	img := (self resourcesPath  / 'images' / 'pharo-stable.zip') asFileReference.
	^ img exists 
		ifTrue: [ img ]
		ifFalse: [ nil ]
]

{ #category : #action }
PhLLaunchImageCommand >> quit [
	(PhLQuitCommand on: self model) execute
]

{ #category : #accessing }
PhLLaunchImageCommand >> resourcesPath [
	| vmDirectory |
	
	vmDirectory := Smalltalk vm binary parent.

	Smalltalk os isMacOSX ifTrue: [ ^ vmDirectory parent / 'Resources' ].
	Smalltalk os isUnix ifTrue: [ ^ vmDirectory parent/ 'shared' ].
	Smalltalk os isWindows ifTrue: [ ^ vmDirectory ].
]

{ #category : #accessing }
PhLLaunchImageCommand >> title [

	^ 'Launch ', launchConfiguration displayName
]
