"
Visitor used to configure the process to launch image dependending on the target OS platform.
"
Class {
	#name : #PhLImageProcessConfigurator,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'process',
		'launchInALoginShell',
		'launchConfiguration'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'private - unix' }
PhLImageProcessConfigurator >> cleanLDLibraryPath [
	^ (self currentLDLibraryPaths
		reject: [ :path | path = FileLocator vmDirectory pathString ])

]

{ #category : #visiting }
PhLImageProcessConfigurator >> configureVm [
	super visit.	"platform specific behavior"
	launchConfiguration vm isHeadless
		ifTrue: [ process addArgument: launchConfiguration vm class headlessOptionString ].
	launchConfiguration vmArguments 
		do: [ :arg | process addArgument: arg ].
]

{ #category : #'private - unix' }
PhLImageProcessConfigurator >> currentLDLibraryPaths [
	^ (OSEnvironment current at: 'LD_LIBRARY_PATH' ifAbsent: [ '' ])
		substrings: ':'
]

{ #category : #'private - unix' }
PhLImageProcessConfigurator >> exportLDLibraryPathCommandWith: vmDirectoryPath [
	^ 'export LD_LIBRARY_PATH=' ,
		($: join: ((self cleanLDLibraryPath copyWithFirst: vmDirectoryPath) collect: #surroundedBySingleQuotes))

]

{ #category : #accessing }
PhLImageProcessConfigurator >> imageFile [
	^ launchConfiguration image imageFile
]

{ #category : #accessing }
PhLImageProcessConfigurator >> launchConfiguration: aPhLLaunchConfiguration [
	launchConfiguration := aPhLLaunchConfiguration
]

{ #category : #accessing }
PhLImageProcessConfigurator >> launchInALoginShell: anObject [
	launchInALoginShell := anObject
]

{ #category : #accessing }
PhLImageProcessConfigurator >> usePharoSettings [
	^ launchConfiguration isUsingPharoSettings
]

{ #category : #visiting }
PhLImageProcessConfigurator >> visit [
	process := PhLProcessWrapper new.
	process workingDirectory: self imageFile parent pathString.
	self configureVm.
	process
		addArgument: self imageFile pathString surroundedByDoubleQuotes.
	self usePharoSettings
		ifFalse: [ process addArgument: '--no-default-preferences' ].
	launchConfiguration imageArguments 
		do: [ :arg | process addArgument: arg ].
	^ process
]

{ #category : #visiting }
PhLImageProcessConfigurator >> visitGeneric: aPlatform [
	launchInALoginShell
		ifTrue: [ process loginShellCommand.
					process addArgument: self vmPath surroundedByDoubleQuotes ]
		ifFalse: [process command: self vmPath "surroundedByDoubleQuotes" ].
]

{ #category : #visiting }
PhLImageProcessConfigurator >> visitUnix: aPlatform [
	
	launchInALoginShell
		ifTrue: [ process loginShellCommand ]
		ifFalse: [ process shellCommand ].
	process 
		addArguments: (self exportLDLibraryPathCommandWith: self vmDirectoryPath);
		addArguments: '&& export SQUEAK_PLUGINS="" &&';
		addArgument: self vmPath.
]

{ #category : #private }
PhLImageProcessConfigurator >> vmDirectoryPath [
	^ self vmPath asFileReference parent fullName
]

{ #category : #private }
PhLImageProcessConfigurator >> vmPath [
	^ launchConfiguration vm executablePath
]
