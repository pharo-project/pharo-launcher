querying
availableVirtualMachinesByImageFormat
	^ [ self availableVirtualMachinesIn: self class privateVmStore] 
		on: PhLExecutableNotFoundError 
		do: [ :ex | ex path asFileReference ensureDeleteAll. ex retry ]