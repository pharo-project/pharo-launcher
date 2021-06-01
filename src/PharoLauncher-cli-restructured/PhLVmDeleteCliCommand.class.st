"
I represent Pharo Virtual Machine delete sub-command invoked from cmd line of Pharo Launcher. My responsibility is to delete local virtual marchine within Pharo launcher based on specified vm name. 

I declare: 
- mandatory positional with existing vm name, based on which is vm deleted

I execute:
- delete vm based on specified vm name
"
Class {
	#name : #PhLVmDeleteCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmDeleteCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #delete launcherModel: aPharoLauncherModel
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
  ^ (arguments at: #existingVirtualMachineName) word
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> execute [
   self outputDeleteVm: self VMName
]

{ #category : #initialization }
PhLVmDeleteCliCommand >> outputDeleteVm: aVMName [

	| aVM virtualMachinesList |
	virtualMachinesList :=  self pharoLauncherModel vmBaseRepository availableVirtualMachines values.
	
	[ aVM := virtualMachinesList
		detect: [ :virtualMachine | virtualMachine id = aVMName ] ]
		on: NotFound
		do: [ :c |  
			self outStream nextPutAll: 'please enter a correct local virtual machine name';
			cr.
			^ self ].
	
	aVM removeFromSystem
]
