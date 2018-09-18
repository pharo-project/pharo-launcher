updating
update
	"fetch a new version of this Virtual Machine if available"
	PhLVirtualMachineManager 
		fetch: self downloadUrl
		to: self name