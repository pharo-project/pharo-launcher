"
I'm a visitor used to generate a command string out of the given PhLProcessWrapper instance.
"
Class {
	#name : #PhLProcessWrapperCommandStringGenerator,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'processWrapper',
		'sequenceSeparator',
		'shellCommandBlock'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #accessing }
PhLProcessWrapperCommandStringGenerator >> processWrapper: aPhLProcessWrapper [
	processWrapper := aPhLProcessWrapper 
]

{ #category : #visiting }
PhLProcessWrapperCommandStringGenerator >> visitGeneric: aPlatform [
	| commandLine |
	commandLine := processWrapper workingDirectory 
		ifNil: [ '' ]
		ifNotNil: [ 'cd ' ,  processWrapper workingDirectory surroundedByDoubleQuotes, sequenceSeparator ].
	 processWrapper isShellCommand 
		ifFalse: [ commandLine := commandLine ,  processWrapper command surroundedByDoubleQuotes, ' ' ].
	commandLine := commandLine , (Character space join:  processWrapper arguments).
	^  processWrapper isShellCommand 
		ifTrue: [ shellCommandBlock value: commandLine ]
		ifFalse: [ commandLine ]

]

{ #category : #visiting }
PhLProcessWrapperCommandStringGenerator >> visitMacOS: aPlatform [
	^ self visitUnix: aPlatform
]

{ #category : #visiting }
PhLProcessWrapperCommandStringGenerator >> visitUnix: aPlatform [
	sequenceSeparator := ' && '.
	shellCommandBlock := [ :commandLine | 'bash -c ''{1}''' format: { commandLine } ].
	^ self visitGeneric: aPlatform
]

{ #category : #visiting }
PhLProcessWrapperCommandStringGenerator >> visitWindows: aPlatform [
	sequenceSeparator := ' & '.
	shellCommandBlock := [ :commandLine | 'C:\Windows\System32\cmd.exe /C ', commandLine surroundedByDoubleQuotes ].
	^ self visitGeneric: aPlatform
]
