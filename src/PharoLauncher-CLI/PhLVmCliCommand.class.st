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

{ #category : #'command line - arguments' }
PhLVmCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #existingVirtualMachineId 
		description: 'Specifies the local Virtual Machine ID.')
	implicitMeaning: [:arg :app | app raiseMissingVM]
]

{ #category : #'command line - converting' }
PhLVmCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #vm 
]

{ #category : #'command line' }
PhLVmCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to VM management.'
]

{ #category : #'error signalling' }
PhLVmCliCommand class >> raiseMissingVM [

	^ NotFound  signal: 'An argument is missing, please enter the correct virtual machine name.'
]

{ #category : #'find-select' }
PhLVmCliCommand >> findVM [

	^ 	[self vmRepository detect: [:vm | vm id = self vmId ]]
		on: NotFound
		do: [ self raiseVMNotFound: self vmId ]
]

{ #category : #private }
PhLVmCliCommand >> modelClass [
	^ self class environment at: #PhLVirtualMachine
]

{ #category : #printing }
PhLVmCliCommand >> raiseVMNotFound: vmID [

	^ NotFound signal: ('Virtual machine with id ''{1}'' not found. Please enter a correct VM id.' format: { vmID })
]

{ #category : #'find-select' }
PhLVmCliCommand >> vmId [

  ^ self positional: #existingVirtualMachineId
]
