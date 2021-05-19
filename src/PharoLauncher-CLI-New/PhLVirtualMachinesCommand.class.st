"
Implement all the commands for the pharo launcher related to Virtual Machines. 
"
Class {
	#name : #PhLVirtualMachinesCommand,
	#superclass : #Object,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> list [
	<commandline>
	^ (ClapCommand withName: 'list')
		description: 'Lists all available VMs, with status.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				self outputListVMsAsSton. 
				ston exitSuccess ].
         self outputListVMs. 
		 ]
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> outputListVMs [
  self new outputListVirtualMachines 
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> outputListVMsAsSton [
	self new outputListVirtualMachinesAsSton
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> virtualMachinesCommands [
	<commandline>
	^(ClapCommand withName: 'virtualMachines')
	 description: 'for virtual machines';
	 add: (self list).
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout.
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputListVirtualMachines [
   | virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   virtualMachinesList do: [ :aVM | stream nextPutAll: aVM asString.stream cr.].
  
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputListVirtualMachinesAsSton [

	stream nextPutAll: (STON toString: (repository availableVirtualMachines collect: [:each | each file ]))
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> repository: anObject [ 
	repository := anObject
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
