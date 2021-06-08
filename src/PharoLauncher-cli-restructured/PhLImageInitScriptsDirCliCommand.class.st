"
I represent Pharo Image sub-command invoked from cmd line of Pharo Launcher. My responsibility is to set the directory of the initialization script.


"
Class {
	#name : #PhLImageInitScriptsDirCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageInitScriptsDirCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #initScriptDir 

]

{ #category : #'command line' }
PhLImageInitScriptsDirCliCommand class >> launcherCmdDescription [

	^ 'Prints, sets directory path, where init scripts for images are located.'
]

{ #category : #'command line - arguments' }
PhLImageInitScriptsDirCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #directoryName)
		description: 'The initialization scripts directory will be set to that local directory.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #accessing }
PhLImageInitScriptsDirCliCommand >> directoryName [ 
  ^ (arguments at: #directoryName) word
]

{ #category : #accessing }
PhLImageInitScriptsDirCliCommand >> execute [
   self initScriptsDir: self directoryName
]

{ #category : #accessing }
PhLImageInitScriptsDirCliCommand >> initScriptsDir: aDirectoryName [
   "how to definitely set a pharo launcher variable ? "

   PharoLauncherApplication default scriptsDirectory: aDirectoryName asFileReference .
   Smalltalk saveSession.
]
