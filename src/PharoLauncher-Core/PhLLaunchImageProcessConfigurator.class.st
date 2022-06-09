"
Visitor used to configure the process to launch image dependending on the target OS platform.
"
Class {
	#name : #PhLLaunchImageProcessConfigurator,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'process',
		'launchInALoginShell',
		'launchConfiguration'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'private - unix' }
PhLLaunchImageProcessConfigurator >> cleanLDLibraryPath [
	^ (self currentLDLibraryPaths
		reject: [ :path | path = FileLocator vmDirectory pathString ])

]

{ #category : #private }
PhLLaunchImageProcessConfigurator >> configurePotentialInitializationScript [
	launchConfiguration image shouldRunInitializationScript 
		ifFalse: [ ^ self ].
		
	launchConfiguration image initializationScript 
		ifNotNil: [ :script | 
						process 
							addArgument: 'eval';
							addArgument: script fullName surroundedByDoubleQuotes ].
]

{ #category : #visiting }
PhLLaunchImageProcessConfigurator >> configureVm [
	super visit.	"platform specific behavior"
	launchConfiguration vm isHeadless
		ifTrue: [ process addArgument: launchConfiguration vm class headlessOptionString ].
	launchConfiguration vmArguments 
		do: [ :arg | process addArgument: arg ].
]

{ #category : #'private - unix' }
PhLLaunchImageProcessConfigurator >> currentLDLibraryPaths [
	^ (OSEnvironment current at: 'LD_LIBRARY_PATH' ifAbsent: [ '' ])
		substrings: ':'
]

{ #category : #'private - unix' }
PhLLaunchImageProcessConfigurator >> exportLDLibraryPathCommandWith: vmDirectoryPath [
	^ 'export LD_LIBRARY_PATH=' ,
		($: join: ((self cleanLDLibraryPath copyWithFirst: vmDirectoryPath) collect: #surroundedBySingleQuotes))

]

{ #category : #accessing }
PhLLaunchImageProcessConfigurator >> imageFile [
	^ launchConfiguration image imageFile
]

{ #category : #accessing }
PhLLaunchImageProcessConfigurator >> launchConfiguration: aPhLLaunchConfiguration [
	launchConfiguration := aPhLLaunchConfiguration
]

{ #category : #accessing }
PhLLaunchImageProcessConfigurator >> launchInALoginShell [
	^ launchInALoginShell ifNil: [ launchConfiguration class launchInALoginShell ]
]

{ #category : #accessing }
PhLLaunchImageProcessConfigurator >> launchInALoginShell: anObject [
	launchInALoginShell := anObject
]

{ #category : #accessing }
PhLLaunchImageProcessConfigurator >> usePharoSettings [
	^ launchConfiguration isUsingPharoSettings
]

{ #category : #visiting }
PhLLaunchImageProcessConfigurator >> visit [
	process := PhLProcessWrapper new.
	process workingDirectory: launchConfiguration workingDirectory pathString.
	self configureVm.
	process
		addArgument: self imageFile pathString surroundedByDoubleQuotes.
	self usePharoSettings
		ifFalse: [ process addArgument: '--no-default-preferences' ].
	self configurePotentialInitializationScript.
	launchConfiguration imageArguments 
		do: [ :arg | process addArgument: arg ].
	^ process
]

{ #category : #visiting }
PhLLaunchImageProcessConfigurator >> visitGeneric: aPlatform [
	self launchInALoginShell
		ifTrue: [ process loginShellCommand.
					process addArgument: self vmPath surroundedByDoubleQuotes ]
		ifFalse: [process command: self vmPath "surroundedByDoubleQuotes" ].
]

{ #category : #visiting }
PhLLaunchImageProcessConfigurator >> visitUnix: aPlatform [
	self launchInALoginShell
		ifTrue: [ process loginShellCommand ]
		ifFalse: [ process shellCommand ].
	process 
		addArguments: (self exportLDLibraryPathCommandWith: self vmDirectoryPath);
		addArguments: '&& export SQUEAK_PLUGINS="" &&';
		addArgument: self vmPath.
]

{ #category : #private }
PhLLaunchImageProcessConfigurator >> vmDirectoryPath [
	^ self vmPath asFileReference parent fullName
]

{ #category : #private }
PhLLaunchImageProcessConfigurator >> vmPath [
	^ launchConfiguration vm executablePath
]
