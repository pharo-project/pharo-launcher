Extension { #name : #FTTableMorph }

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
FTTableMorph >> clickOnColumnHeaderAt: anIndex [
	| header |
	header := self container headerRow submorphs at: anIndex.
	header click: (MouseButtonEvent basicNew 
							setType: #mouseDown;
							yourself).
		
]
