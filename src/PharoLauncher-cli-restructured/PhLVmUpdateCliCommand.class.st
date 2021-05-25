Class {
	#name : #PhLVmUpdateCliCommand,
	#superclass : #PhLVmCliCommand,
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmUpdateCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #update
]

{ #category : #'command line' }
PhLVmUpdateCliCommand class >> launcherCmdDescription [

	^ 'Updates VM executable, including depedent libs to latest version from remote site.'
]

{ #category : #'command line - arguments' }
PhLVmUpdateCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingVirtualMachineName)
		description: 'Local VM name to be deleted.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #initialization }
PhLVmUpdateCliCommand >> VMName [ 
  ^arguments words at: 2.
]

{ #category : #accessing }
PhLVmUpdateCliCommand >> execute [
   | arg1 |
    
   arg1 := self VMName.
   self outputUpdateVm: arg1.
   
]

{ #category : #initialization }
PhLVmUpdateCliCommand >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout.
]

{ #category : #accessing }
PhLVmUpdateCliCommand >> outputUpdateVm: aVMName [
   | aVM virtualMachinesList |
   virtualMachinesList := repository availableVirtualMachines values.
   [aVM := virtualMachinesList detect: [ :virtualMachine | virtualMachine id = aVMName ]]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local virtual machine name'.stream cr.^0].
   aVM updateFromUrl. 
   
]

{ #category : #initialization }
PhLVmUpdateCliCommand >> repository: anObject [ 
	repository := anObject
]

{ #category : #initialization }
PhLVmUpdateCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
