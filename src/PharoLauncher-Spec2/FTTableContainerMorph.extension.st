Extension { #name : #FTTableContainerMorph }

{ #category : #'*PharoLauncher-Spec2' }
FTTableContainerMorph >> themeChanged [

	"reset rows color to follow the new theme if needed"
	rowColors ifNotNil: [ self alternateRowsColor ].
	super themeChanged.
]
