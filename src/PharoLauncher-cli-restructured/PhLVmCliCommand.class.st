"
I represent Pharo virtual machines sub-command of Pharo Launcher. My responsibility is to take care of Pharo virtual machines sub-commands. 

I use: 
 - Pharo launcher root command to declare my other sub-commands.

I declare: 
- delete, list, info, update sub-commands


"
Class {
	#name : #PhLVmCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #vm 
]

{ #category : #'command line' }
PhLVmCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to VM management.'
]

{ #category : #'find-select' }
PhLVmCliCommand >> VMName [ 
  ^ (arguments at: #existingVirtualMachineName) word 
	
]

{ #category : #'command execution' }
PhLVmCliCommand >> execute [
	[ self executeWithVM: (self findVM) ]
		on: NotFound
		do: [ ^ self messageErrorNotFound ].
]

{ #category : #'find-select' }
PhLVmCliCommand >> findVM [
	^ self vmRepository detect: [ :virtualMachine | virtualMachine id = self VMName ] 
	
]

{ #category : #printing }
PhLVmCliCommand >> messageErrorNotFound [
			self errorStream nextPutAll: 'please enter a correct local virtual machine'.
			self errorStream cr.
			^ self
]
