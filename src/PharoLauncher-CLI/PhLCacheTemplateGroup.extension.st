Extension { #name : #PhLCacheTemplateGroup }

{ #category : #'*PharoLauncher-CLI' }
PhLCacheTemplateGroup >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	delegate class = anObject class ifFalse: [ ^ false ].
	^ delegate = anObject 
]
