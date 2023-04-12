"
I represent Pharo Virtual Machine delete sub-command invoked from cmd line of Pharo Launcher. My responsibility is to delete local virtual marchine within Pharo launcher based on specified vm name. 

I declare: 
- mandatory positional with existing vm name, based on which is vm deleted

I execute:
- delete vm based on specified vm name
"
Class {
	#name : #PhLVmDeleteCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLVmDeleteCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #delete 
]

{ #category : #'command line' }
PhLVmDeleteCliCommand class >> launcherCmdDescription [

	^ 'Deletes VM executable from local computer, including dependencies.'
]

{ #category : #'command execution' }
PhLVmDeleteCliCommand >> basicExecute [

   self findVM removeFromSystem
]
