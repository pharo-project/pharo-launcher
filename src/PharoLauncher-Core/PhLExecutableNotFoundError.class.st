"
Error thrown when Pharo Launcher did not succeed to find a Pharo binary or executable inside a given folder.
Probably, the folder should be deleted as the VM are only cached
"
Class {
	#name : #PhLExecutableNotFoundError,
	#superclass : #PhLError,
	#instVars : [
		'path',
		'kindOfApplication'
	],
	#category : 'PharoLauncher-Core-Download'
}

{ #category : #signalling }
PhLExecutableNotFoundError class >> signalKind: aKindOfApp inPath: aString [
	^ self new
		kindOfApplication: aKindOfApp;
		path: aString;
		signal
]

{ #category : #accessing }
PhLExecutableNotFoundError >> kindOfApplication: string [
	kindOfApplication := string
]

{ #category : #accessing }
PhLExecutableNotFoundError >> longDescription [
	^ 'Cannot detect Pharo ', kindOfApplication ,' in ', path, '.', String cr, 'Delete the folder and retry! It can also due to a corruption of the downloaded file...'
]

{ #category : #accessing }
PhLExecutableNotFoundError >> name [
	^ 'Pharo Executable Not Found'
]

{ #category : #accessing }
PhLExecutableNotFoundError >> path [
	^ path
]

{ #category : #accessing }
PhLExecutableNotFoundError >> path: string [
	path := string
]
