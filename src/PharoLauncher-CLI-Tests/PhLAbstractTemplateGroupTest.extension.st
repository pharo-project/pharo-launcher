Extension { #name : #PhLAbstractTemplateGroupTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLAbstractTemplateGroupTest >> testListPrintAttributeBlocks [

	|categories blocks|
	categories := PhLTemplateGroupRepository default roots.
	blocks := categories anyOne class listPrintAttributeBlocks.
	self assert: ((blocks collect: [:aBlock| aBlock value: categories anyOne]) allSatisfy: #isString)
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLAbstractTemplateGroupTest >> testListPrintAttributeLabels [

	self assert: (PhLCacheTemplateGroup listPrintAttributeLabels allSatisfy: #isString)
]
