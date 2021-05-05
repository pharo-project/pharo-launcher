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
		"add: ((ClapFlag withName: 'ston') description: 'To save on STON format');"
		meaning: [ :args |
			
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			"args atName: 'ston' ifFound: [ :ston |
				self outputListImagesAsSton. 
				ston exitSuccess ]."
         self outputListVMs. 
		 ]
]

{ #category : #'as yet unclassified' }
ClapListVMs class >> outputListVMs [
  self new outputListVirtualMachines 
]

{ #category : #accessing }
ClapListVMs >> initialize [

	stream := VTermOutputDriver stdout.
]

{ #category : #'as yet unclassified' }
ClapListVMs >> outputListVirtualMachines [
   | virtualMachinesList |
   virtualMachinesList := PhLVirtualMachineManager new. 
   virtualMachinesList := virtualMachinesList availableVirtualMachines values.
   virtualMachinesList do: [ :aVM | stream nextPutAll: aVM asString].
  
]

{ #category : #accessing }
ClapListVMs >> stream: aWriteStream [ 
	stream := aWriteStream
]
