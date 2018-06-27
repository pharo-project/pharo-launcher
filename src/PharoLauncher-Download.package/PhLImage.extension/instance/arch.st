*PharoLauncher-Download
arch
	| formatNumber |
	formatNumber := self formatNumber.
	((PhLVirtualMachineManager is32bits: formatNumber)
		or: [ PhLVirtualMachineManager isPreSpur: formatNumber ])
		ifTrue: [ ^ '32' ].
	(PhLVirtualMachineManager is64bits: formatNumber)
		ifTrue: [ ^ '64' ].
	^ 'N/A'