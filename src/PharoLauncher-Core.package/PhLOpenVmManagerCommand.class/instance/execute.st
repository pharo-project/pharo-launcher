action
execute
	| vmBlock privateVmBlock |
	vmBlock := [ PhLVirtualMachineManager new availableVirtualMachines 
		asSortedCollection: [ :vm1 :vm2 | vm1 name > vm2 name ] ].
	privateVmBlock := [ PhLVirtualMachineManager new availableVirtualMachinesByImageFormat 
		asSortedCollection: [ :vm1 :vm2 | vm1 name > vm2 name ] ].
	(PhLVMPresenter on: { vmBlock . privateVmBlock }) openWithSpec