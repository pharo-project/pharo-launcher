"
I represent Pharo Virtual machine list sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list available virtual machines. 

I declare: 
- optional flag for stonOutput

I execute:
- list local virtual machines with detailed information.
"
Class {
	#name : #PhLVmListCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLVmListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line' }
PhLVmListCliCommand class >> launcherCmdDescription [

	^ 'Lists all available VMs, with status.'
]

{ #category : #accessing }
PhLVmListCliCommand >> execute [
	| counter |
	counter := 1.
	self vmRepository
		do: [ :aVM | 
			self outStream
				nextPutAll: counter asString;
				nextPutAll: ' ';
				nextPutAll: aVM id;
				newLine.
			counter := counter + 1 ]
]
