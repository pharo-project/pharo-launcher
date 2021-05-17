Class {
	#name : #PhLVirtualMachineCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI-New'
}

{ #category : #tests }
PhLVirtualMachineCommandTest >> testDeleteVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='delete'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testDeleteVm [

	| repo command vm1 vm2 vm3 |
	
	repo := PhLVirtualMachinesMockRepo new.
	command := PhLVirtualMachinesCommand new.
	command repository: repo.
	vm1 := PhLVirtualMachinesMock id:'MyVirtualMachine'.
	vm2 := PhLVirtualMachinesMock id:'MyVirtualMachine2'.
	vm3 := PhLVirtualMachinesMock id:'MyVirtualMachine3'.
	
	repo availableVirtualMachines at:'70-x64' put:vm1;
   at:'71-x64' put:vm2;
   at:'72-x64' put:vm3.

	command outputDeleteVm: 'MyVirtualMachine2'.
	
	self assert: vm2 state equals:'successfully deleted'
	

]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testExecuteCommandListVMs [
	| command output |
	command := PhLVirtualMachinesCommand new.
	

]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testInfoVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='info'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testListVirtualMachines [
   | repo command vm1 vm2 vm3 output |
	
	repo := PhLVirtualMachinesMockRepo new.
	command := PhLVirtualMachinesCommand new.
	command repository: repo.
	vm1 := PhLVirtualMachinesMock id:'MyVirtualMachine'.
	vm2 := PhLVirtualMachinesMock id:'MyVirtualMachine2'.
	vm3 := PhLVirtualMachinesMock id:'MyVirtualMachine3'.
	
	repo availableVirtualMachines at:'70-x64' put:vm1;
   at:'71-x64' put:vm2;
   at:'72-x64' put:vm3.

   output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListVirtualMachines ].
   self assert: output equals: 'MyVirtualMachine2
MyVirtualMachine3
MyVirtualMachine
'

]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testListVirtualMachinesAsSton [
	| repo command vm1 output |
	repo := PhLVirtualMachinesMockRepo new.
	command := PhLVirtualMachinesCommand new.
	command repository: repo.
	vm1 := PhLVirtualMachinesMock id: 'MyVirtualMachine'.
	
	repo availableVirtualMachines
		at: '70-x64' put: vm1.
		
	"output := String
		streamContents: [ :s | 
			command stream: s.
			command outputListVirtualMachinesAsSton ]."

	"self assert: (STON fromString: output) equals: {repo} asDictionary."
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testListVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='list'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testUpdateVirtualMachinesWithSubcommand [
	| command |
	command :=ClapContext pragmaCommands detect:[:c | c canonicalName = 'virtualMachines'].
	command := command subcommands detect:[ :f | f canonicalName ='update'].
	self assert: command flags size equals:2.
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='help']).
	self assert: (command flags anySatisfy:[ :c | c canonicalName ='ston'])
]

{ #category : #tests }
PhLVirtualMachineCommandTest >> testUpdateVm [

	| repo command vm1 vm2 vm3 |
	
	repo := PhLVirtualMachinesMockRepo new.
	command := PhLVirtualMachinesCommand new.
	command repository: repo.
	vm1 := PhLVirtualMachinesMock id:'MyVirtualMachine'.
	vm2 := PhLVirtualMachinesMock id:'MyVirtualMachine2'.
	vm3 := PhLVirtualMachinesMock id:'MyVirtualMachine3'.
	
	repo availableVirtualMachines at:'70-x64' put:vm1;
   at:'71-x64' put:vm2;
   at:'72-x64' put:vm3.

	command outputUpdateVm: 'MyVirtualMachine2'.
	
	self assert: vm2 state equals:'updated'
	

]
