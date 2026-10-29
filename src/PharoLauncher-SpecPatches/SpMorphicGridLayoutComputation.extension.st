Extension { #name : 'SpMorphicGridLayoutComputation' }

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpMorphicGridLayoutComputation >> calculateNotHomogeneousColumnWidths [
	"Column widths are 
	 - the max width of cells of that column. EXCEPT if
	 - the column is expandable, in which case, they will receive the remaining width 
	   after assigning the others (a minimum if there is no remaining place)"
	| newColumnWidths expandables |

	newColumnWidths := Array new: numColumns withAll: 0.
	
	"Assign non expandable values, 
	 skip spanned columns (otherwise column will take an spanned width)"
	morphs 
		select: [ :each | (each valueOfProperty: #gridConstraints) columnSpan = 1 ]
		thenDo: [ :each | | column |
			column := (each valueOfProperty: #gridConstraints) column.
			(self isColumnExpandable: column) ifFalse: [ 
				newColumnWidths 
					at: column
					put: ((newColumnWidths at: column) max: (self widthOf: each))] ].
		
	"now I count the zeroes, if there are remaining means we need to assign the remaining 
	 width (divided between the remaining)"
	expandables := newColumnWidths count: [ :each | each isZero ].
	expandables > 0 ifTrue: [ | width accumulatedWidth |
		accumulatedWidth := (newColumnWidths reject: [ :each | each isZero ]) 
			ifNotEmpty: [ :nonZeroWidths | nonZeroWidths sum ]
			ifEmpty: [ 0 ]. 
		"Column positions add columnSpacing between columns: keep it out of the remaining width"
		accumulatedWidth := accumulatedWidth + ((numColumns - 1) * self layout columnSpacing).
		width := ((bounds width - accumulatedWidth) / expandables) asInteger.
		newColumnWidths := newColumnWidths collect: [ :each | 
			each = 0 
				ifTrue: [ width ]
				ifFalse: [ each ] ] ].
		
	^ newColumnWidths
]

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpMorphicGridLayoutComputation >> heightOf: aMorph [ 
	| height |

	
	height := (self geometryPropertyOf: aMorph) ifNotNil: [ :geometry | geometry height ].
	^ (height isNil or: [ height = 0 ])
		ifTrue: [ (self naturalExtentOf: aMorph) y ]
		ifFalse: [ height ]
]

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpMorphicGridLayoutComputation >> naturalExtentOf: aMorph [
	"Alignment wrappers (see SpMorphicGridAdapter>>#basicApplyChildrenAlignmentTo:constraints:)
	 are rigid: their extent is the default morph extent or the one of the cell they were laid
	 in, not the one of their content. Measure their content instead."

	^ (aMorph hasProperty: #gridAlignmentWrapper)
		ifTrue: [ aMorph layoutPolicy minExtentOf: aMorph in: aMorph bounds ]
		ifFalse: [ aMorph extent ]
]

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpMorphicGridLayoutComputation >> widthOf: aMorph [ 
	| width |

	width := (self geometryPropertyOf: aMorph) ifNotNil: [ :geometry | geometry width ].
	^ (width isNil or: [ width = 0 ])
		ifTrue: [ (self naturalExtentOf: aMorph) x ]
		ifFalse: [ width ]
]
