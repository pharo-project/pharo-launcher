private
fetchSourcesFilesFor: anImageVersionString
	| vmFolder |
	
	vmFolder := (self availableVirtualMachines at: self vmFileName) vmFolder.
	self fetchSourcesFilesFor: anImageVersionString in: vmFolder
