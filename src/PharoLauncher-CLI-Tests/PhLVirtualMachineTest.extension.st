Extension { #name : #PhLVirtualMachineTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLVirtualMachineTest >> testListPrintAttributeBlocks [

	|blocks vm| 
	vm := PhLVirtualMachine new 
		basicInitializeOn: FileSystem memory / '80-x64';
		yourself.
	blocks := vm class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: vm ]) allSatisfy: #isString).
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLVirtualMachineTest >> testListPrintAttributeLabels [

	self assert: (PhLVirtualMachine listPrintAttributeLabels allSatisfy: #isString)
]
