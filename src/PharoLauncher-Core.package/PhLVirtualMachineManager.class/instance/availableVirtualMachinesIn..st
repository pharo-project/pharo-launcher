private
availableVirtualMachinesIn: aFileReference
	| vmsOnDisk |
	vmsOnDisk := Dictionary new.
	aFileReference directories
		do: [ :entry |
			(entry allChildrenMatching: self class vmExecutableName) 
				detect: #isFile
				ifFound: [ :vmExecutablePath | 
					vmsOnDisk 
						at: entry basename 
						put: vmExecutablePath fullName ] ].
	^ vmsOnDisk