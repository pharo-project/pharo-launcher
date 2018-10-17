*PharoLauncher-Pharo6
selectFirstVMVisibleRow
	^ self selectRowIndex: (container exposedRows
		ifNotEmpty: [ :rows | rows keys first ]
		ifEmpty: [ 0 ]).