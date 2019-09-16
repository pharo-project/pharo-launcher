Class {
	#name : #PhLLaunchImageAdvancedCommand,
	#superclass : #PhLImageCommand,
	#classVars : [
		'CommandAnnouncer',
		'QuitOnLaunch',
		'WarnOnArchMismatch'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLLaunchImageAdvancedCommand class >> announceQuitOnLaunchValueChanged [
	self announcer announce: PhLQuitOnLaunchValueChanged
]

{ #category : #accessing }
PhLLaunchImageAdvancedCommand class >> announcer [
	^ CommandAnnouncer ifNil: [ CommandAnnouncer := Announcer new ]
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> archMismatchSettingDescription [
	^ 'Get a warning when trying to launch an image with a different architecture than the Launcher (i.e. trying to launch a 32-bit image from Pharo Launcher 64-bit). '
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> archMismatchSettingLabel [
	^ 'Warn on image architecture mismatch? ' translated
]

{ #category : #accessing }
PhLLaunchImageAdvancedCommand class >> group [
	^ 1
]

{ #category : #accessing }
PhLLaunchImageAdvancedCommand class >> icon [
	^ self iconNamed: #smallDoItIcon
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> quitOnLaunch [
	^ QuitOnLaunch ifNil: [  QuitOnLaunch := false ].
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> quitOnLaunch: aBoolean [
	| oldValue |
	oldValue := QuitOnLaunch.
	QuitOnLaunch := aBoolean.
	oldValue = QuitOnLaunch 
		ifFalse: [ CommandAnnouncer announce: PhLQuitOnLaunchValueChanged ]
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> settingsOn: aBuilder [
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
PhLLaunchImageAdvancedCommand class >> title [
	^ 'Launch Pablo...'
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> warnOnArchMismatch [
	^ WarnOnArchMismatch ifNil: [  WarnOnArchMismatch := true ].
]

{ #category : #settings }
PhLLaunchImageAdvancedCommand class >> warnOnArchMismatch: aBoolean [
	WarnOnArchMismatch := aBoolean.

]

{ #category : #converting }
PhLLaunchImageAdvancedCommand >> asMenuItem [
	^ super asMenuItem
		subMenu: (MenuPresenter new
			addGroup: [ :group |
				self model singleImage configurations do: [ :e |
					 group addMenuItem: (MenuItemPresenter new
						name: e name;
						action: [ self model singleImage launchWithConfiguration: e ];
						yourself)]
				];
			addGroup: [ :group |
				group addMenuItem: (MenuItemPresenter new
					name: 'Edit...';
					action: [ (PhLEditImageConfiguration on: self model singleImage) openWithSpec ]
					yourself) ])
]

{ #category : #action }
PhLLaunchImageAdvancedCommand >> execute [
	self model hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]
]

{ #category : #testing }
PhLLaunchImageAdvancedCommand >> isApplicable [
	^ self model hasSingleImageSelected
]

{ #category : #action }
PhLLaunchImageAdvancedCommand >> launchImage: aPhLImage [
	[ aPhLImage launchWithSettings: true ]
		on: PhLError
		do: [ :error | error uiAlert ].
	self class quitOnLaunch
		ifTrue: [ self quit ]
]

{ #category : #action }
PhLLaunchImageAdvancedCommand >> launchImageFromDisk [
	| imagePath |
	imagePath := UIManager default 
		chooseFullFileName: 'Open a Pharo image'
		extensions: #('image') 
		path: FileLocator home 
		preview: false.
	imagePath ifNil: [ ^ self ].
	imagePath asFileReference isFile ifFalse: [ ^self ].
	self launchImage: (PhLImage location: imagePath asFileReference)
]

{ #category : #action }
PhLLaunchImageAdvancedCommand >> launchSelectedImage [
	self launchImage: self model singleImage
]

{ #category : #accessing }
PhLLaunchImageAdvancedCommand >> pharoStableImagePath [
	| img |
	img := (self resourcesPath  / 'images' / 'pharo-stable.zip') asFileReference.
	^ img exists 
		ifTrue: [ img ]
		ifFalse: [ nil ]
]

{ #category : #action }
PhLLaunchImageAdvancedCommand >> quit [
	(PhLQuitCommand on: self model) execute
]

{ #category : #accessing }
PhLLaunchImageAdvancedCommand >> resourcesPath [
	| vmDirectory |
	
	vmDirectory := Smalltalk vm binary parent.

	Smalltalk os isMacOSX ifTrue: [ ^ vmDirectory parent / 'Resources' ].
	Smalltalk os isUnix ifTrue: [ ^ vmDirectory parent/ 'shared' ].
	Smalltalk os isWindows ifTrue: [ ^ vmDirectory ].
]
