Extension { #name : #FTSmartColumnDataSource }

{ #category : #'*PharoLauncher-IceTray' }
FTSmartColumnDataSource >> hasRow: aRowIndex [
	^ self elements size >= aRowIndex
]
