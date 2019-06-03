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
		'meta'
	],
	#classVars : [
		'LaunchInALoginShell'
	],
	#category : 'PharoLauncher-Core-Model'
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
		reject: [ :path | path = FileLocator vmDirectory pathString ])

]

{ #category : #private }
PhLImage >> currentLDLibraryPathes [
	^ (OSEnvironment current at: 'LD_LIBRARY_PATH' ifAbsent: [ '' ])
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

{ #category : #action }
PhLImage >> launchCommandWith: vmCommand useSettings: usePharoSettings [
	| imagePath vmDirectoryPath command basicCommand |
	imagePath := file pathString.
	vmDirectoryPath := vmCommand asFileReference parent fullName.
	command := String
		streamContents: [ :cmd | 
			cmd << 'cd ' << file parent pathString surroundedByDoubleQuotes << ' && '.
			Smalltalk os isUnix
				ifTrue: [ cmd << (self exportLDLibraryPathCommandWith: vmDirectoryPath) << ' && export SQUEAK_PLUGINS="" && ' ].
			cmd << vmCommand surroundedByDoubleQuotes << ' ' << imagePath surroundedByDoubleQuotes.
			usePharoSettings ifFalse: [ cmd << ' --no-default-preferences' ] ].
	basicCommand := self class launchInALoginShell
		ifTrue: [ Smalltalk os isWindows
				ifTrue: [ 'cmd /C ' , command ]
				ifFalse: [ 'bash -l -c ''' , command , '''' ] ]
		ifFalse: [ command ].
	^ basicCommand "utf8Encoded asString"
]

{ #category : #action }
PhLImage >> launchCommandWithVm: vmManager useSettings: usePharoSettings [
	| shouldUsePharoSettings |
	shouldUsePharoSettings := usePharoSettings.
	vmManager imageVersion < '30' " Cannot skip Pharo settings before 3.0"
		ifTrue: [ shouldUsePharoSettings := true ].
	
	^ self launchCommandWith: vmManager vm useSettings: shouldUsePharoSettings
]

{ #category : #action }
PhLImage >> launchWithSettings: usePharoSettings [
	| architectureWarningEnabled continue |
	architectureWarningEnabled := true.
	continue := true.
	[ [ | vmManager |
	vmManager := PhLVirtualMachineManager forImage: file pathString.
	^ PhLProcessWrapper command: (self launchCommandWithVm: vmManager useSettings: usePharoSettings) ]
		on: PhLImageVersionDeterminationError, PhLNotSupportedCharacterError
		do: [ :error |  error uiAlert ] ]
		on: PhLArchitectureMismatchWarning
		do: [ :warning | |  |
			(PhLLaunchImageCommand warnOnArchMismatch and: [ architectureWarningEnabled  ])
				ifTrue: [ 
					architectureWarningEnabled := false. "only raise one warning"
					continue := YesNoDialogWithTickBoxWindow confirm: warning longDescription label: warning name. ].
			continue ifTrue: [ warning resume ]. ]
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

{ #category : #accessing }
PhLImage >> sourcesFile [
	^ self file parent files 
		detect: [ :fileRef | fileRef extension = 'sources' ]
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

{ #category : #accessing }
PhLImage >> versionFile [
	^ self file parent / PhLVirtualMachineManager imageVersionFileName
]

{ #category : #action }
PhLImage >> vm [
	^ (PhLVirtualMachineManager forImage: file pathString) vmFileName
]
