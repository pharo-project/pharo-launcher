querying
availableVirtualMachinesOnDiskByImageFormat
	^[ self availableVirtualMachinesIn: self privateVmStore] on: PhLExecutableNotFoundError do: [ :ex |  self privateVmStore deleteAllChildren. ex retry ]