Extension { #name : #PhLCacheTemplateGroup }

{ #category : #'*PharoLauncher-CLI' }
PhLCacheTemplateGroup >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	delegate class = anObject class ifFalse: [ ^ false ].
	^ delegate = anObject 
]

{ #category : #'*PharoLauncher-CLI' }
PhLCacheTemplateGroup class >> listPrintAttributeBlocks [
	
	^ {[:templateGroup | templateGroup name]}
]

{ #category : #'*PharoLauncher-CLI' }
PhLCacheTemplateGroup class >> listPrintAttributeLabels [
	
	^ #('Template category' )
]
