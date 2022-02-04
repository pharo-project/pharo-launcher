Extension { #name : #PhLAbstractTemplateTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLAbstractTemplateTest >> testListPrintAttributeBlocks [

	|blocks aTemplate| 
	aTemplate := self newTemplate.
	blocks := aTemplate class listPrintAttributeBlocks.
	self assert: (blocks allSatisfy: #isBlock).
	self assert: ((blocks collect: [ :aBlock | aBlock value: aTemplate ]) allSatisfy: #isString).
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLAbstractTemplateTest >> testListPrintAttributeLabels [
	| template |
	
	template := self newTemplate.
	self assert: (template class listPrintAttributeLabels allSatisfy: #isString)
]
