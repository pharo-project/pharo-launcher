"
I represent Pharo virtual machine update sub-command invoked from cmd line of Pharo Launcher. My responsibility is to update available virtual machines.

I declare: 
- optional flag for stonOutput

I execute:
- update the virtual machine according to the name.
"
Class {
	#name : #PhLVmUpdateCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmUpdateCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #update launcherModel: aPharoLauncherModel
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
   ^ (arguments at: #existingVirtualMachineName) word
]

{ #category : #accessing }
PhLVmUpdateCliCommand >> execute [
   self outputUpdateVm: self VMName
]

{ #category : #accessing }
PhLVmUpdateCliCommand >> outputUpdateVm: aVMName [
	| aVM virtualMachinesList |
	virtualMachinesList := self pharoLauncherModel vmBaseRepository
		availableVirtualMachines values.
	[ aVM := virtualMachinesList
		detect: [ :virtualMachine | virtualMachine id = aVMName ] ]
		on: Error , NotFound
		do: [ :c | 
			self outStream
				nextPutAll: 'please enter a correct local virtual machine name'.
			self outStream cr.
			^ self ].
	aVM updateFromUrl
]
