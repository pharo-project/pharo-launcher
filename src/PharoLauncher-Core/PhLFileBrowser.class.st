"
I'm a simple visitor in charge of opening an operating system browser on the provided path string.
"
Class {
	#name : #PhLFileBrowser,
	#superclass : #OSPlatformVisitor,
	#instVars : [
		'process',
		'vmPath',
		'launchInALoginShell',
		'imageFile',
		'usePharoSettings',
		'path'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLFileBrowser class >> openOn: aFileReferenceOrPathString [

	^ self new 
		path: aFileReferenceOrPathString;
		open.
]

{ #category : #action }
PhLFileBrowser >> open [ 
	self visit
]

{ #category : #accessing }
PhLFileBrowser >> path: aFileReferenceOrPathString [
	"Opens an OS-specific file and directory browser on ==aFileReference==. If aFileReference is a file, opens the browser on its containing directory instead."

	| ref |
	aFileReferenceOrPathString ifNil: [ ^ nil ].
	ref := aFileReferenceOrPathString asFileReference.
	ref exists ifFalse: [ ^ nil ].

	ref := ref isFile
		ifTrue: [ ref parent ]
		ifFalse: [ ref ].
	(ref isNil or: [ ref exists not ]) ifTrue: [ ^ nil ].

	path := ref fullName
]

{ #category : #visiting }
PhLFileBrowser >> visitMacOS: aPlatform [
	^ PhLProcessWrapper new 
		shellCommand;
		addArgument: ('open "{1}"' format: {path});
		runUnwatch
]

{ #category : #visiting }
PhLFileBrowser >> visitUnix: aPlatform [
	^  PhLProcessWrapper new 
		shellCommand;
		addArgument: ('xdg-open "{1}"' format: {path});
		runUnwatch
]

{ #category : #visiting }
PhLFileBrowser >> visitWindows: aPlatform [
	^ aPlatform privShellExplore: path
]
