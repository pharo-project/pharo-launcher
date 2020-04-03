Extension { #name : #SpMorphicTableAdapter }

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
SpMorphicTableAdapter >> clickOnColumnHeaderAt: anIndex [
	self widgetDo: [ :tableWidget | tableWidget clickOnColumnHeaderAt: anIndex ]
]

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
SpMorphicTableAdapter >> ifSorted: sortedBlock ifNotSorted: notSortedBlock [ 
	widget columns 
		do: [ :column | | state | 
			state := column sortingStrategy state.
			state isSorted
				ifTrue: [ ^ sortedBlock cull: state ] ].
	^ notSortedBlock value	
]

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
SpMorphicTableAdapter >> refreshModel [

	widget dataSource resetElements.
	self
		ifSorted: [ :sortingStrategyState | sortingStrategyState executeSortingOn: widget dataSource ]
		ifNotSorted: [ widget refresh ]
]
