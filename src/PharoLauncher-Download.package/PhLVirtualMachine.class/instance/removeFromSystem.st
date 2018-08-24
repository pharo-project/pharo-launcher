actions
removeFromSystem
	| vmFolder zipFile |
	vmFolder := PhLVirtualMachineManager vmStore / self name.
	vmFolder exists
		ifTrue: [ vmFolder ensureDeleteAll ].
	zipFile := PhLVirtualMachineManager vmStore / (self name, '.zip').
	zipFile exists
		ifTrue: [ zipFile ensureDelete ].
