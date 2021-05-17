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
PhLVirtualMachinesCommand class >> delete [
	<commandline>
	^ (ClapCommand withName: 'delete')
		description: 'delete a VM executable from the computer, including dependences.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args | | aVMName |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputListVMsAsSton." 
				ston exitSuccess ].
			aVMName := args parent parent parent arguments at:3.
         self outputDeleteVm: aVMName. 
		 ]
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> info [
	<commandline>
	^ (ClapCommand withName: 'info')
		description: 'Prints information about VM: name, remote-site URL, last update status...';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args | | aVMName |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputListVMsAsSton." 
				ston exitSuccess ].
			aVMName := args parent parent parent arguments at:3.
         self outputInfoVm: aVMName. 
		 ]
]

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
PhLVirtualMachinesCommand class >> outputDeleteVm: aVMName [
  self new outputDeleteVm: aVMName. 
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> outputInfoVm: aVMName [
  self new outputInfoVm: aVMName. 
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
PhLVirtualMachinesCommand class >> outputUpdateVm: aVMName [
  self new outputUpdateVm: aVMName. 
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> update [
	<commandline>
	^ (ClapCommand withName: 'update')
		description: 'update a VM including dependences.';
		add: ClapFlag forHelp;
		add: ((ClapFlag withName: 'ston') description: 'To save on STON format');
		meaning: [ :args | | aVMName |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			args atName: 'ston' ifFound: [ :ston |
				"self outputListVMsAsSton." 
				ston exitSuccess ].
			aVMName := args parent parent parent arguments at:3.
         self outputUpdateVm: aVMName. 
		 ]
]

{ #category : #'as yet unclassified' }
PhLVirtualMachinesCommand class >> virtualMachinesCommands [
	<commandline>
	^(ClapCommand withName: 'virtualMachines')
	 description: 'for virtual machines';
	 add: (self list);
	 add: (self delete);
	 add: (self info);
	 add: (self update).
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout.
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputDeleteVm: aVMName [

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

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputInfoVm: aVMName [
   | aVM virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   [aVM := virtualMachinesList detect: [ :virtualMachine | virtualMachine id = aVMName ]]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct virtual machine name'.stream cr.^0]..
   stream nextPutAll: 'name: ';
          nextPutAll: aVM id;
          lf;
          nextPutAll: 'last update: ';
          nextPutAll: aVM lastUpdateTime asString;
          lf;
          nextPutAll: 'download Url: ';
          nextPutAll: aVM downloadUrl asString;
          lf.
          

   
  
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputListVirtualMachines [
   | virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   virtualMachinesList do: [ :aVM | stream nextPutAll: aVM id.stream lf.].
  
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputListVirtualMachinesAsSton [

	stream nextPutAll: (STON toString: (repository availableVirtualMachines collect: [:each | each file ]))
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> outputUpdateVm: aVMName [
   | aVM virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   [aVM := virtualMachinesList detect: [ :virtualMachine | virtualMachine id = aVMName ]]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local virtual machine name'.stream cr.^0].
   aVM updateFromUrl. 
   
  
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> repository: anObject [ 
	repository := anObject
]

{ #category : #accessing }
PhLVirtualMachinesCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
