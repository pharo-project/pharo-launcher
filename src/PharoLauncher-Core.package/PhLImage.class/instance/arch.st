accessing
arch
	| formatNumber |
	formatNumber := self formatNumber.
	((PhDVirtualMachineManager is32bits: formatNumber)
		or: [ PhDVirtualMachineManager isPreSpur: formatNumber ])
		ifTrue: [ ^ '32' ].
	(PhDVirtualMachineManager is64bits: formatNumber)
		ifTrue: [ ^ '64' ].
	^ 'N/A'