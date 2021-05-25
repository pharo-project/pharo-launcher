Class {
	#name : #PhLVmDeleteCliCommand,
	#superclass : #PhLVmCliCommand,
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmDeleteCliCommand class >> asCliCommand [
		
	^ self newLauncherCommand: #delete
]

{ #category : #'command line' }
PhLVmDeleteCliCommand class >> launcherCmdDescription [

	^ 'Deletes VM executable from local computer, including dependencies.'
]

{ #category : #'command line' }
PhLVmDeleteCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingVirtualMachineName)
		description: 'Local VM name to be deleted.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> VMName [ 
  ^arguments words at: 2.
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> execute [
   | arg1 |
    
   arg1 := self VMName.
   self outputDeleteVm: arg1.
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout.
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> outputDeleteVm: aVMName [

	| aVM virtualMachinesList |
	
	virtualMachinesList := repository availableVirtualMachines values.
	
	[ aVM := virtualMachinesList
		detect: [ :virtualMachine | virtualMachine id = aVMName ] ]
		on: NotFound
		do: [ :c | 
			stream nextPutAll: 'please enter a correct local virtual machine name'.
			stream cr.
			^ self ].

	aVM removeFromSystem
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> repository: anObject [ 
	repository := anObject
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
