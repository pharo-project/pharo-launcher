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
  ^arguments words at: 2.
]

{ #category : #accessing }
PhLImageInitScriptsDirCliCommand >> execute [
   | arg1 |
    
   arg1 := self directoryName.
   self outputInitScriptsDir: arg1.
]

{ #category : #accessing }
PhLImageInitScriptsDirCliCommand >> outputInitScriptsDir: aDirectoryName [
   "how to definitely set a pharo launcher variable ? "

   PharoLauncherApplication default scriptsDirectory: aDirectoryName asFileReference .
   Smalltalk saveSession.
]
