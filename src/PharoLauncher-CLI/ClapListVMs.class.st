"
https://github.com/Bajger/Pharo-snippets/blob/master/pharoLauncherCmdLine-description.md
"
Class {
	#name : #ClapListVMs,
	#superclass : #Object,
	#instVars : [
		'stream',
		'repository'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'as yet unclassified' }
ClapListVMs class >> listVirtualMachines [
	<commandline>
	^ (ClapCommand withName: 'listVMs')
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
ClapListVMs class >> outputListVMs [
  self new outputListVirtualMachines 
]

{ #category : #'as yet unclassified' }
ClapListVMs class >> outputListVMsAsSton [
	self new outputListVirtualMachinesAsSton
]

{ #category : #accessing }
ClapListVMs >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout.
]

{ #category : #'as yet unclassified' }
ClapListVMs >> outputListVirtualMachines [
   | virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   virtualMachinesList do: [ :aVM | stream nextPutAll: aVM asString.stream cr.].
  
]

{ #category : #'as yet unclassified' }
ClapListVMs >> outputListVirtualMachinesAsSton [

	stream nextPutAll: (STON toString: (repository availableVirtualMachines collect: [:each | each file ]))
  
]

{ #category : #accessing }
ClapListVMs >> repository: anObject [ 
	repository := anObject
]

{ #category : #accessing }
ClapListVMs >> stream: aWriteStream [ 
	stream := aWriteStream
]
