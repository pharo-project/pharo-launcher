private
availableVirtualMachinesIn: aFileReference
	| vmsOnDisk |
	vmsOnDisk := Dictionary new.
	aFileReference directories
		do: [ :entry |
			self
				detectExecutable: self class vmExecutableName
				in: entry
				ifFound: [ :vmExecutablePath | 
					vmsOnDisk 
						at: entry basename 
						put: vmExecutablePath fullName ] ].
	^ vmsOnDisk