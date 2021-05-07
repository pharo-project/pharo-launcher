Class {
	#name : #ClapListVirtualMachinesTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-CLI'
}

{ #category : #tests }
ClapListVirtualMachinesTest >> testExecuteCommandWhenThereIsMoreVirtualMachinePrintsTheListOfVMs [
	| command output repo |
	command := ClapListVMs new.
   repo := PhLMockVirtualMachinesRepository new.
   repo availableVirtualMachines: Dictionary new.
   repo availableVirtualMachines at:'70-x64' put:'MyVirtualMachine';
   at:'71-x64' put:'MyVirtualMachine2'.
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListVirtualMachines ].
   self assert: output equals: 'MyVirtualMachine2MyVirtualMachine'.
]

{ #category : #tests }
ClapListVirtualMachinesTest >> testExecuteCommandWhenThereIsOneVirtualMachinePrintsTheListOfVMs [
	| command output repo |
	command := ClapListVMs new.
   repo := PhLMockVirtualMachinesRepository new.
   repo availableVirtualMachines: Dictionary new.
   repo availableVirtualMachines at:'70-x64' put:'MyVirtualMachine'. 
	output := String
		streamContents: [ :s | 
			command repository: repo.
			command stream: s.
			command outputListVirtualMachines ].
   self assert: output equals: 'MyVirtualMachine'.
]
