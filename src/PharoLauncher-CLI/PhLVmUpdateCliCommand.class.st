"
I represent Pharo virtual machine update sub-command invoked from cmd line of Pharo Launcher. My responsibility is to update available virtual machines.

I declare: 
- optional flag for stonOutput

I execute:
- update the virtual machine according to the name.
"
Class {
	#name : #PhLVmUpdateCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLVmUpdateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #update 
]

{ #category : #'command line' }
PhLVmUpdateCliCommand class >> launcherCmdDescription [

	^ 'Updates VM executable, including dependent libs to latest version from remote site.'
]

{ #category : #accessing }
PhLVmUpdateCliCommand >> executeWithVM: aVm [
   aVm updateFromUrl
]
