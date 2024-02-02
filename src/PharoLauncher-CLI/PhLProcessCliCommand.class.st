"
I represent a Pharo process sub-command of Pharo Launcher. My responsibility is to take care of Pharo process sub-commands.

I use:
- Pharo launcher root command to declare my other sub-commands.

I declare:

•	list, kill


I execute:

•	just printing help about my sub-commands relevant for Pharo templates
"
Class {
	#name : #PhLProcessCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLProcessCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #process 
]

{ #category : #'command line - description' }
PhLProcessCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to Pharo processes.'
]

{ #category : #private }
PhLProcessCliCommand >> checkOS [

	OSPlatform current isWindows ifTrue: [ self raiseOperationNotSupported ]
]

{ #category : #accessing }
PhLProcessCliCommand >> currentVMPid [

	^ OSSVMProcess vmProcess pid
]

{ #category : #'command execution' }
PhLProcessCliCommand >> executeOSShellCommand [

	^ self executeOSShellCommandWithArgs: self osShellArgArray
]

{ #category : #'command execution' }
PhLProcessCliCommand >> executeOSShellCommandWithArgs: argArray [

^ PhLProcessWrapper new 
		shellCommand;
		addAllArguments: argArray;
		runAndWaitWithStdOutput
]

{ #category : #'error signalling' }
PhLProcessCliCommand >> raiseOperationNotSupported [

	^ PhLProcessCommandError signal: 'Launcher command currently not supported on OS Windows.'
]
