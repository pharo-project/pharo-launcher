Class {
	#name : #PhLVmInfoCliCommand,
	#superclass : #PhLVmCliCommand,
	#instVars : [
		'repository',
		'stream'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmInfoCliCommand class >> asCliCommand [
		
	^ self newLauncherCommand: #info
]

{ #category : #'command line' }
PhLVmInfoCliCommand class >> launcherCmdDescription [

	^ 'Prints information about VM: name, remote-site URL, last update status, etc.'
]

{ #category : #'command line - arguments' }
PhLVmInfoCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingVirtualMachineName)
		description: 'Local VM name to be deleted.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | app ];
		yourself)}
]

{ #category : #initialization }
PhLVmInfoCliCommand >> VMName [ 
  ^arguments words at: 2.
]

{ #category : #accessing }
PhLVmInfoCliCommand >> execute [
   | arg1 |
    
   arg1 := self VMName.
   self outputInfoVm: arg1.
]

{ #category : #accessing }
PhLVmInfoCliCommand >> initialize [
   repository := PhLVirtualMachineManager new.
	stream := VTermOutputDriver stdout.
]

{ #category : #accessing }
PhLVmInfoCliCommand >> outputInfoVm: aVMName [
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
PhLVmInfoCliCommand >> repository: anObject [ 
	repository := anObject
]

{ #category : #accessing }
PhLVmInfoCliCommand >> stream: aWriteStream [ 
	stream := aWriteStream
]
