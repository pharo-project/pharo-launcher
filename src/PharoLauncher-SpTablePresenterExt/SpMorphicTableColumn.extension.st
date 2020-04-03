Extension { #name : #SpMorphicTableColumn }

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
SpMorphicTableColumn >> isSorted [

	^ self sortingStrategy state isSorted
]
