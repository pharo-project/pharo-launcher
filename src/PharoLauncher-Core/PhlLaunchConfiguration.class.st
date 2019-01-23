Class {
	#name : #PhlLaunchConfiguration,
	#superclass : #Object,
	#instVars : [
		'command',
		'usePharoSettings'
	],
	#category : #'PharoLauncher-Core'
}

{ #category : #'instance-creation' }
PhlLaunchConfiguration class >> command: aCommand [

	^ self new
		command: aCommand;
		yourself
]

{ #category : #'instance-creation' }
PhlLaunchConfiguration class >> default [

	^ self new
		command: '{vm} {image}';
		yourself
]

{ #category : #'path-helpers' }
PhlLaunchConfiguration >> cleanLDLibraryPath [
	^ (self currentLDLibraryPathes
		reject: [ :path | path asByteArray utf8Decoded = FileLocator vmDirectory pathString ])
]

{ #category : #accessing }
PhlLaunchConfiguration >> command [
	^ command
]

{ #category : #accessing }
PhlLaunchConfiguration >> command: anObject [
	command := anObject
]

{ #category : #'path-helpers' }
PhlLaunchConfiguration >> currentLDLibraryPathes [
	^ ((OSEnvironment current getEnv: 'LD_LIBRARY_PATH') ifNil: [ '' ])
		substrings: ':'
]

{ #category : #'path-helpers' }
PhlLaunchConfiguration >> exportLDLibraryPathCommandWith: vmDirectoryPath [
	^ 'export LD_LIBRARY_PATH=' ,
		($: join: ((self cleanLDLibraryPath copyWithFirst: vmDirectoryPath) collect: #surroundedBySingleQuotes))
]

{ #category : #initialization }
PhlLaunchConfiguration >> initialize [

	super initialize.
	usePharoSettings := false
]

{ #category : #accessing }
PhlLaunchConfiguration >> launchCommandForImage: anImage [
	| basicCommand vmPath |
	vmPath := (PhLVirtualMachineManager forImage:
		anImage pathString) vm asFileReference.
	basicCommand := String
		streamContents: [ :cmd | | vmString imageString |
			cmd << 'cd ' <<
				anImage directory pathString surroundedByDoubleQuotes << ' && '.
			Smalltalk os isUnix
				ifTrue: [ cmd << (self exportLDLibraryPathCommandWith: vmPath parent)
						<< ' && export SQUEAK_PLUGINS="" && ' ].
			vmString := vmPath fullName surroundedByDoubleQuotes.
			imageString := anImage pathString surroundedByDoubleQuotes.
			usePharoSettings ifFalse: [ imageString := imageString, ' --no-default-preferences' ].
			cmd
				<<
					(command
						format:
							{('vm' -> vmString).
							('image' -> imageString)} asDictionary) ].
	basicCommand := PhLImage launchInALoginShell
		ifTrue: [ Smalltalk os isWindows
				ifTrue: [ 'cmd /C ' , basicCommand ]
				ifFalse: [ 'bash -l -c ''' , basicCommand , '''' ] ].
	^ basicCommand
]

{ #category : #accessing }
PhlLaunchConfiguration >> usePharoSettings [
	^ usePharoSettings
]

{ #category : #accessing }
PhlLaunchConfiguration >> usePharoSettings: anObject [
	usePharoSettings := anObject
]
