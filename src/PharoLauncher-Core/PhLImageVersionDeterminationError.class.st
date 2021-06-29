"
Error thrown when Pharo Launcher did not succeed to determine the Pharo version of the image to launch.
Probably, the run command failed.
I hold the command run to determoine the version so that it can be reused for debugging purposes.
"
Class {
	#name : #PhLImageVersionDeterminationError,
	#superclass : #PhLError,
	#instVars : [
		'command'
	],
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #signalling }
PhLImageVersionDeterminationError class >> signalCommand: aCommandString [
	^ self new
		setCommand: aCommandString;
		signal
]

{ #category : #accessing }
PhLImageVersionDeterminationError >> longDescription [
	^ PhLImage versionFileName , 
	' file was not found for your image, and probably your VMs are not up to date.
Please, contact us at http://pharo.org/community'
]

{ #category : #accessing }
PhLImageVersionDeterminationError >> name [
	^ 'Cannot determine image version'
]

{ #category : #initialization }
PhLImageVersionDeterminationError >> setCommand: aCommandString [
	command := aCommandString reject: [ :c | c = Character cr ] "easier to run the copy/pasted command in a shell if command has only one line"
]
