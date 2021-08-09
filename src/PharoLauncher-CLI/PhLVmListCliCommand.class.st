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

{ #category : #'command line - arguments' }
PhLVmListCliCommand class >> launcherCmdFlags [
	^ {((ClapFlag id: #ston)
		description: 'Allows to list images with ston output ';
		meaning: [ :arg :app | true ];
		implicitMeaning: [ :arg :app | false ])}
]

{ #category : #accessing }
PhLVmListCliCommand >> execute [
	self outputAsSton 
		ifTrue: [ ^ self outputAsSton: self vmRepository ].
	self list: self vmRepository
]
