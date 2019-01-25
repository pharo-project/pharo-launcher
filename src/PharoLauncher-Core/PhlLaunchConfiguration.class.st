Class {
	#name : #PhlLaunchConfiguration,
	#superclass : #Object,
	#instVars : [
		'command',
		'usePharoSettings',
		'name'
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
		name: 'default';
		yourself
]

{ #category : #accessing }
PhlLaunchConfiguration class >> defaultCommand [

	^ '{vm} {image}'
]

{ #category : #'instance-creation' }
PhlLaunchConfiguration class >> defaultWithoutSettings [

	^ self new
		name: 'without settings';
		usePharoSettings: false;
		yourself
]

{ #category : #'instance-creation' }
PhlLaunchConfiguration class >> named: aString [ 
	
	^ self new
		name: aString;
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

{ #category : #accessing }
PhlLaunchConfiguration >> defaultCommand [

	^ self class defaultCommand
]

{ #category : #displaying }
PhlLaunchConfiguration >> displayName [

	^ self name ifEmpty: [ '<no name>' ]
]

{ #category : #'path-helpers' }
PhlLaunchConfiguration >> exportLDLibraryPathCommandWith: vmDirectoryPath [
	^ 'export LD_LIBRARY_PATH=' ,
		($: join: ((self cleanLDLibraryPath copyWithFirst: vmDirectoryPath) collect: #surroundedBySingleQuotes))
]

{ #category : #initialization }
PhlLaunchConfiguration >> initialize [

	super initialize.
	name := ''.
	command := self defaultCommand.
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
PhlLaunchConfiguration >> name [
	^ name
]

{ #category : #accessing }
PhlLaunchConfiguration >> name: aString [ 
	
	name := aString
]

{ #category : #accessing }
PhlLaunchConfiguration >> usePharoSettings [
	^ usePharoSettings
]

{ #category : #accessing }
PhlLaunchConfiguration >> usePharoSettings: anObject [
	usePharoSettings := anObject
]
