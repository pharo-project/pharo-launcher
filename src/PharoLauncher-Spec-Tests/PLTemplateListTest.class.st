Class {
	#name : #PLTemplateListTest,
	#superclass : #PLAbstractSpecTestCase,
	#instVars : [
		'templateRepository'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #tests }
PLTemplateListTest >> setUp [ 

	super setUp.

	templateRepository := PhLTemplateGroupRepository newFromGroups: PhLTemplateGroupsBuilder build.
	
	instance := PLTemplateList on: templateRepository.
	instance application: SpecApplication new.
	window := instance openWithSpec
]

{ #category : #tests }
PLTemplateListTest >> testCategoryListIsShown [

	self assert: (window hasPresenter: instance categoryList)
]

{ #category : #tests }
PLTemplateListTest >> testCategoryListShowsModelCategories [

	self assert: instance categoryList items equals: templateRepository categories
]

{ #category : #tests }
PLTemplateListTest >> testSelectCategoryPopulatesTheImageTree [

	instance categoryList selectedItem: templateRepository categories first.
	
	self assert: instance templateTree roots equals: templateRepository categories first children
]

{ #category : #tests }
PLTemplateListTest >> testSelectedCategoryStartsEmpty [

	self assert: instance selectedCategory equals: nil
]

{ #category : #tests }
PLTemplateListTest >> testSelectionStartsEmpty [ 

	self assert: instance selectedImage equals: nil
]

{ #category : #tests }
PLTemplateListTest >> testTemplateTreeIsShown [

	self assert: (window hasPresenter: instance templateTree)
]
