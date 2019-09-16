"
Visitor used to configure the process to launch image dependending on the target OS platform.
"
Class {
	#name : #PhLImageProcessConfigurator,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'process',
		'vmPath',
		'launchInALoginShell',
		'imageFile',
		'usePharoSettings',
		'imageArguments'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'private - unix' }
PhLImageProcessConfigurator >> cleanLDLibraryPath [
	^ (self currentLDLibraryPaths
		reject: [ :path | path = FileLocator vmDirectory pathString ])

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
PhLImageProcessConfigurator >> imageArguments: aString [ 

	imageArguments := aString
]

{ #category : #accessing }
PhLImageProcessConfigurator >> imageFile: anObject [
	imageFile := anObject
]

{ #category : #accessing }
PhLImageProcessConfigurator >> launchInALoginShell: anObject [
	launchInALoginShell := anObject
]

{ #category : #accessing }
PhLImageProcessConfigurator >> usePharoSettings: anObject [
	usePharoSettings := anObject
]

{ #category : #visiting }
PhLImageProcessConfigurator >> visit [ 
	| imagePath |

	imagePath := imageFile pathString.
	process := PhLProcessWrapper new.
	process workingDirectory: imageFile parent pathString.
	
	super visit. "add platform specific behavior"
		
	process addArgument: imagePath surroundedByDoubleQuotes.
	usePharoSettings ifFalse: [ process addArgument: '--no-default-preferences' ].
	process addArgument: imageArguments.

	^ process
]

{ #category : #visiting }
PhLImageProcessConfigurator >> visitGeneric: aPlatform [
	launchInALoginShell
		ifTrue: [ process loginShellCommand.
					process addArgument: vmPath surroundedByDoubleQuotes ]
		ifFalse: [process command: vmPath "surroundedByDoubleQuotes" ].
]

{ #category : #visiting }
PhLImageProcessConfigurator >> visitUnix: aPlatform [
	
	launchInALoginShell
		ifTrue: [ process loginShellCommand ]
		ifFalse: [ process shellCommand ].
	process 
		addArguments: (self exportLDLibraryPathCommandWith: self vmDirectoryPath);
		addArguments: '&& export SQUEAK_PLUGINS="" &&';
		addArgument: vmPath.
]

{ #category : #private }
PhLImageProcessConfigurator >> vmDirectoryPath [
	^ vmPath asFileReference parent fullName
]

{ #category : #accessing }
PhLImageProcessConfigurator >> vmPath: anObject [
	vmPath := anObject
]
