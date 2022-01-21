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
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLVmCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #vm 
]

{ #category : #'command line' }
PhLVmCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to VM management.'
]

{ #category : #'command line - arguments' }
PhLVmCliCommand class >> launcherCmdPositionals [
	^ {
	((ClapPositional id: #existingVirtualMachineId)
		description: 'Local Virtual Machine id.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app |
			NotFound signal: 'one argument is missing, need a virtual machine name to update it'. ];
		yourself)
	}
]

{ #category : #'command execution' }
PhLVmCliCommand >> execute [
	[ self executeWithVM: self findVM ]
		on: NotFound
		do: [ ^ self logVMNotFound  ]
]

{ #category : #'find-select' }
PhLVmCliCommand >> findVM [
	^ self vmRepository
		detect: [ :virtualMachine | virtualMachine id = self vmId ]
]

{ #category : #printing }
PhLVmCliCommand >> logVMNotFound [
	self errorStream
		nextPutAll: 'please enter a correct local virtual machine'.
	self errorStream newLine.
	^ self
]

{ #category : #'find-select' }
PhLVmCliCommand >> vmId [
  ^ (arguments at: #existingVirtualMachineId) word 
	
]
