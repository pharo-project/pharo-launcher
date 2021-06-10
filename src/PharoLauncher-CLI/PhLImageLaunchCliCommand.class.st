"
I represent Pharo Image launch sub-command invoked from cmd line of Pharo Launcher. My responsibility is to launch local image with auto-detected VM within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image name, based on which is image launched

I execute:
- launch local image with auto-detected VM
"
Class {
	#name : #PhLImageLaunchCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'process'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launch 
]

{ #category : #'command line' }
PhLImageLaunchCliCommand class >> launcherCmdDescription [

	^ 'Launches image with using default (auto-detected) VM.'
]

{ #category : #'command line - arguments' }
PhLImageLaunchCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name which will be launched.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #accessing }
PhLImageLaunchCliCommand >> executeWithImage: anImage [
   anImage launch
]
