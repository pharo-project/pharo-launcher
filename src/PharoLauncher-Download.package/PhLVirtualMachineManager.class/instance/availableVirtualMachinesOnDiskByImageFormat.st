querying
availableVirtualMachinesOnDiskByImageFormat
	^ [ self availableVirtualMachinesIn: self privateVmStore] 
		on: PhLExecutableNotFoundError 
		do: [ :ex |  ex path asFileReference ensureDeleteAll. ex retry ]