Extension { #name : #PhLAbstractTemplate }

{ #category : #'*PharoLauncher-CLI' }
PhLAbstractTemplate class >> listPrintAttributeBlocks [
	
	^ {[:template | template name].
		[:template | template url asString]}
]

{ #category : #'*PharoLauncher-CLI' }
PhLAbstractTemplate class >> listPrintAttributeLabels [
	
	^ #('Template name' 'URL')
]
