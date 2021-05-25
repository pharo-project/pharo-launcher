Class {
	#name : #PhLVmListCliCommand,
	#superclass : #PhLVmCliCommand,
	#instVars : [
		'repository',
		'stream'
	],
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
   self outputListVirtualMachines .
]

{ #category : #accessing }
PhLVmListCliCommand >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout
]

{ #category : #accessing }
PhLVmListCliCommand >> outputListVirtualMachines [
   | virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   virtualMachinesList do: [ :aVM | stream nextPutAll: aVM id.stream lf.].
]

{ #category : #accessing }
PhLVmListCliCommand >> repository: anObject [ 
	repository := anObject
]

{ #category : #accessing }
PhLVmListCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
