private
availableVirtualMachinesIn: aFileReference
	| vmsOnDisk |
	vmsOnDisk := Dictionary new.
	aFileReference directories
		reject: [ :entry | entry basename = 'private' ]
		thenDo: [ :entry | | vm |
			vm := PhLVirtualMachine directory: entry.
			vm ifValid: [ vmsOnDisk at: entry basename put: vm ] ].
	^ vmsOnDisk