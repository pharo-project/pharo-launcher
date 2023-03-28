"
I represent Pharo virtual machine info sub-command invoked from cmd line of Pharo Launcher. My responsibility is to print info about vitual machine based on specified vm name. 

I declare: 
- mandatory positional with existing virtual machine name, based on which is output with info about vm printed
- optional flag for specifying stonOutput to print result into ston format/file

I execute:
- create new local virtual machine based on specified vm template name with new name specified as flag
"
Class {
	#name : #PhLVmInfoCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLVmInfoCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #info
]

{ #category : #'command line' }
PhLVmInfoCliCommand class >> launcherCmdDescription [

	^ 'Prints information about VM: name, remote-site URL, last update status, etc.'
]

{ #category : #'command execution' }
PhLVmInfoCliCommand >> basicExecute [
  
	self list: (Array with: self findVM)
]

{ #category : #'accessing arguments' }
PhLVmInfoCliCommand >> printSequence [

	^ false
]

{ #category : #'accessing arguments' }
PhLVmInfoCliCommand >> rowMode [

	"vm info is printed in one attribute per row"
	^ true
]
