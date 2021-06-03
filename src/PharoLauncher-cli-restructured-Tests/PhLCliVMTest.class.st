Class {
	#name : #PhLCliVMTest,
	#superclass : #ClapPharoCommandsTest,
	#category : #'PharoLauncher-cli-restructured-Tests'
}

{ #category : #tests }
PhLCliVMTest >> testOutputDeleteVM [

	| command commandContext model  |
	model := PharoLauncherCLIModel new.
	model vmBaseRepository: PhLTestVirtualMachineManager new.
	model vmBaseRepository createVmNamed: 'test2'.
	self assert: model vmBaseRepository availableVirtualMachines size equals: 2.
	self assertCollection: (model vmBaseRepository availableVirtualMachines collect: #name)
		hasSameElements: { model vmBaseRepository singleVmName . 'test2'}.
	command := PhLVmDeleteCliCommand asCliCommand: model.
	commandContext := command activationWith: {'delete' . 'TestVM'}.

	commandContext execute.
	
	self assert: model vmBaseRepository availableVirtualMachines size equals: 1.
	self
		assert: (model vmBaseRepository availableVirtualMachines values at:1)name
		equals:'test2' .	
		
]

{ #category : #tests }
PhLCliVMTest >> testOutputInfoVM [

	| command commandContext model output |
	model := PharoLauncherCLIModel new.
	model vmBaseRepository: PhLTestVirtualMachineManager new.
	model vmBaseRepository createVmNamed: 'test2'.
	self assert: model vmBaseRepository availableVirtualMachines size equals: 2.
	self assertCollection: (model vmBaseRepository availableVirtualMachines collect: #name)
		hasSameElements: { model vmBaseRepository singleVmName . 'test2'}.		
	command := PhLVmInfoCliCommand asCliCommand: model.
	commandContext := command activationWith: {'info'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: output equals: ''
]

{ #category : #tests }
PhLCliVMTest >> testOutputListVM [

	| command commandContext model output |
	model := PharoLauncherCLIModel new.
	model vmBaseRepository: PhLTestVirtualMachineManager new.
	model vmBaseRepository createVmNamed: 'test2'.
	self assert: model vmBaseRepository availableVirtualMachines size equals: 2.
	self assertCollection: (model vmBaseRepository availableVirtualMachines collect: #name)
		hasSameElements: { model vmBaseRepository singleVmName . 'test2'}.			
	command := PhLVmListCliCommand asCliCommand: model.
	commandContext := command activationWith: {'list'}.
	
	commandContext execute.
	
	output := commandContext stdio stdout contents utf8Decoded. 
	self assert: (output includesSubstring: 'TestVM'). 
	self assert: (output includesSubstring: 'test2') 
]
