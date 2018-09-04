action
execute
	| vmBlock |
	vmBlock := [ PhLVirtualMachineManager new availableVirtualMachines 
		asSortedCollection: [ :vm1 :vm2 | vm1 name > vm2 name ] ].
	(PhLVMPresenter on: vmBlock) openWithSpec