"
I represent a Pharo image. I live in a particular location and have a name. Users can launch me.

Instance Variables
	file:		a reference to the .image file

"
Class {
	#name : #PhLImage,
	#superclass : #PhLObject,
	#instVars : [
		'file',
		'meta',
		'launchConfigurations'
	],
	#classVars : [
		'LaunchInALoginShell'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #settings }
PhLImage class >> launchInALoginShell [
	^ LaunchInALoginShell ifNil: [ LaunchInALoginShell := true ].
]

{ #category : #settings }
PhLImage class >> launchInALoginShell: aBoolean [
	LaunchInALoginShell := aBoolean
]

{ #category : #'instance creation' }
PhLImage class >> location: aFile [
	^ self new
		setLocation: aFile 
		yourself
]

{ #category : #settings }
PhLImage class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #launchInALoginShell)
		label: 'Launch image from a login shell' translated;
		parent: #pharoLauncher;
		target: self;
		order: 31;
		description: 'When enabled, Pharo Launcher will start a Shell and launch the image from it. ' , String cr , 'It allows to inherit from the Shell environment variables.'
]

{ #category : #'launch-configurations' }
PhLImage >> addLaunchConfiguration: aPhlLaunchConfiguration [ 

	^ launchConfigurations add: aPhlLaunchConfiguration
]

{ #category : #'launch-configurations' }
PhLImage >> addNewLaunchConfiguration [
	
	^ self addLaunchConfiguration: PhlLaunchConfiguration new
]

{ #category : #quering }
PhLImage >> arch [
	| formatNumber |
	formatNumber := self formatNumber.
	((PhLVirtualMachineManager is32bits: formatNumber)
		or: [ PhLVirtualMachineManager isPreSpur: formatNumber ])
		ifTrue: [ ^ '32' ].
	(PhLVirtualMachineManager is64bits: formatNumber)
		ifTrue: [ ^ '64' ].
	^ 'N/A'
]

{ #category : #accessing }
PhLImage >> changesFile [
	^ self file parent / self file basenameWithoutExtension , 'changes'
]

{ #category : #private }
PhLImage >> cleanLDLibraryPath [
	^ (self currentLDLibraryPathes
		reject: [ :path | path asByteArray utf8Decoded = FileLocator vmDirectory pathString ])

]

{ #category : #private }
PhLImage >> currentLDLibraryPathes [
	^ ((OSEnvironment current getEnv: 'LD_LIBRARY_PATH') ifNil: [ '' ])
		substrings: ':'
]

{ #category : #printing }
PhLImage >> description [
	| dirName f |
	dirName := self file parent fullName.
	f := (dirName , '/description.txt') asFileReference.
	
	^ f exists
		ifTrue: [ f contents withNoLineLongerThan: 80 ]
		ifFalse: [ 'There is no description.txt' ]
]

{ #category : #accessing }
PhLImage >> directory [
	
	^ file parent
]

{ #category : #private }
PhLImage >> exportLDLibraryPathCommandWith: vmDirectoryPath [
	^ 'export LD_LIBRARY_PATH=' ,
		($: join: ((self cleanLDLibraryPath copyWithFirst: vmDirectoryPath) collect: #surroundedBySingleQuotes))

]

{ #category : #accessing }
PhLImage >> file [ 
	^file
]

{ #category : #quering }
PhLImage >> formatNumber [
	^ PhLVirtualMachineManager imageFormatNumberFromFile: file
]

{ #category : #testing }
PhLImage >> hasChildren [
	^ false
]

{ #category : #accessing }
PhLImage >> imageFile [
	^ self file
]

{ #category : #accessing }
PhLImage >> initialize [

	super initialize.
	launchConfigurations := OrderedCollection new.
	launchConfigurations add: PhlLaunchConfiguration default.
]

{ #category : #testing }
PhLImage >> isHighlighted [
	^ false
]

{ #category : #testing }
PhLImage >> isImage [
	^ true
]

{ #category : #accessing }
PhLImage >> lastModification [
	^ self file modificationTime
]

{ #category : #launching }
PhLImage >> launch [

	^ self launchWithConfiguration: PhlLaunchConfiguration default
]

{ #category : #accessing }
PhLImage >> launchConfigurations [
	
	^ launchConfigurations
]

{ #category : #launch }
PhLImage >> launchWithConfiguration: aPhlLaunchConfiguration [

	^ PhLProcessWrapper
		command: (aPhlLaunchConfiguration launchCommandForImage: self)
]

{ #category : #action }
PhLImage >> launchWithSettings: usePharoSettings [
	
	^ self launchWithConfiguration: (PhlLaunchConfiguration default
		usePharoSettings: usePharoSettings;
		yourself)
]

{ #category : #accessing }
PhLImage >> meta [
	^ meta ifNil: [  meta := self metaFromDirectory: file parent ]
]

{ #category : #private }
PhLImage >> metaFromDirectory: aDirectory [
	| myMeta |
	
	myMeta := Dictionary new.
	(aDirectory filesMatching: PhLAbstractTemplate metaInfoFileName)
		do: [ :metaFile | 
			metaFile readStreamDo: [ :stream | 
				[ myMeta addAll: (STON fromStream: stream)]
					on: Error
					do: [ PhLUIInformation new 
							message: ('PharoLauncher error: meta info {1}' format: {  metaFile asString }) ;
							inform ] ] ].
	^ myMeta
]

{ #category : #accessing }
PhLImage >> name [
	^ file basenameWithoutExtension
]

{ #category : #accessing }
PhLImage >> originTemplate [

	^ self meta at: #template ifAbsent: [ nil ]
]

{ #category : #accessing }
PhLImage >> originTemplateName [

	^ self originTemplate ifNotNil: [ :t | t name ] ifNil: [ '' ]
]

{ #category : #accessing }
PhLImage >> path [

	^ file resolve path
]

{ #category : #accessing }
PhLImage >> pathString [
	^ file fullName
]

{ #category : #printing }
PhLImage >> printOn: aStream [
	aStream
		nextPutAll: 'Image (';
		nextPutAll: self name;
		nextPutAll: ')'
]

{ #category : #'initialize-release' }
PhLImage >> setLocation: aFile [ 
	file := aFile.
	
]

{ #category : #printing }
PhLImage >> showNativeFolder [
	OSPlatform current openFileBrowserOn: file
]

{ #category : #printing }
PhLImage >> summaryInfo [
	^ String
		streamContents: [ :s | 
			s nextPutAll: 'Last modified: '.
			self file modificationTime printOn: s.
			s
				cr;
				nextPutAll: self file parent fullName;
				cr;
				cr;
				nextPutAll: self description ]
]

{ #category : #accessing }
PhLImage >> template [
	^ self meta at: #template ifPresent: [ :t | t name ] ifAbsent: [ #unknown ]
]

{ #category : #action }
PhLImage >> vm [
	^ (PhLVirtualMachineManager forImage: file pathString) vmFileName
]
