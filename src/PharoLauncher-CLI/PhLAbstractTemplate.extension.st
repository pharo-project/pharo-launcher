Extension { #name : #PhLAbstractTemplate }

{ #category : #'*PharoLauncher-CLI' }
PhLAbstractTemplate >> cliPrintOn: aStream [
	aStream nextPutAll: self name.
]

{ #category : #'*PharoLauncher-CLI' }
PhLAbstractTemplate class >> listPrintAttributeBlocks [
	
	^ {[:template | template name]}
]

{ #category : #'*PharoLauncher-CLI' }
PhLAbstractTemplate class >> listPrintAttributeLabels [
	
	^ #('Template name')
]
