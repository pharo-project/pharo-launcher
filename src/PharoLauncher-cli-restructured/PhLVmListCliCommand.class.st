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
	#category : #'PharoLauncher-cli-restructured'
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
   self vmRepository
		do: [ :aVM | 
			self outStream nextPutAll: aVM id.
			self outStream lf ]
]
