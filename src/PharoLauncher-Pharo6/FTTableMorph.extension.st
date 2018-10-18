Extension { #name : #FTTableMorph }

{ #category : #'*PharoLauncher-Pharo6' }
FTTableMorph >> selectFirstVMVisibleRow [
	^ self selectRowIndex: (container exposedRows
		ifNotEmpty: [ :rows | rows keys first ]
		ifEmpty: [ 0 ]).
]
