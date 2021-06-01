"
I represent Pharo virtual machine info sub-command invoked from cmd line of Pharo Launcher. My responsibility is to print info about vitual machine based on specified vm name. 

I declare: 
- mandatory positional with existing virtual machine name, based on which is output with info about vm printed
- optional flag for specifying stonOutput to print result into ston format/file

I execute:
- create new local virtual machine based on specified vm template name with new name specified as flag
"
Class {
	#name : #PhLVmInfoCliCommand,
	#superclass : #PhLVmCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLVmInfoCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #delete launcherModel: aPharoLauncherModel
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
  ^ (arguments at: #existingVirtualMachineName) word
]

{ #category : #accessing }
PhLVmInfoCliCommand >> execute [
   self outputInfoVm: self VMName
]

{ #category : #accessing }
PhLVmInfoCliCommand >> outputInfoVm: aVMName [
	| aVM virtualMachinesList |
	virtualMachinesList := self pharoLauncherModel vmBaseRepository
		availableVirtualMachines values.
	[ aVM := virtualMachinesList
		detect: [ :virtualMachine | virtualMachine id = aVMName ] ]
		on: Error , NotFound
		do: [ :c | 
			self outStream
				nextPutAll: 'please enter a correct virtual machine name'.
			self outStream cr.
			^ self ].
	self outStream
		nextPutAll: 'name: ';
		nextPutAll: aVM id;
		lf;
		nextPutAll: 'last update: ';
		nextPutAll: aVM lastUpdateTime asString;
		lf;
		nextPutAll: 'download Url: ';
		nextPutAll: aVM downloadUrl asString;
		lf
]
