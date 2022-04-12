Extension { #name : #PhLImageTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLImageTest >> testExtendedListPrintAttributeBlocks [

	|blocks| 
	blocks := image class extendedListPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: image ]) allSatisfy: #isString).
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLImageTest >> testExtendedListPrintAttributeLabels [

	self assert: (image class extendedListPrintAttributeLabels allSatisfy: #isString).
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLImageTest >> testListPrintAttributeBlocks [

	|blocks| 
	blocks := image class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: image ]) allSatisfy: #isString).
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLImageTest >> testListPrintAttributeLabels [

	self assert: (image class listPrintAttributeLabels allSatisfy: #isString).
]
