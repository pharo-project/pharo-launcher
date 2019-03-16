Class {
	#name : #PLTemplateList,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'categoryList',
		'templateTree'
	],
	#category : #'PharoLauncher-Spec-New'
}

{ #category : #specs }
PLTemplateList class >> defaultSpec [

	^ SpecPanedLayout newHorizontal
		add: (SpecScrollableLayout with: #categoryList);
		add: (SpecScrollableLayout with: #templateTree);
		yourself
]

{ #category : #accessing }
PLTemplateList >> categoryList [

	^ categoryList
]

{ #category : #initialization }
PLTemplateList >> initializePorts [

	self addOutputPort: ListSelectionPresenterPort new
]

{ #category : #initialization }
PLTemplateList >> initializePresenter [

	categoryList items: self model categories
]

{ #category : #initialization }
PLTemplateList >> initializeWidgets [

	categoryList := self newList
		displayBlock: #name;
		yourself.
	templateTree := self newTreeTable.
	
	templateTree 
		addColumn: (StringTableColumn evaluated: #name);
		hideColumnHeaders.
		
	self transmit
		from: categoryList;
		to: templateTree;
		transform: [ :aGroup | aGroup children ]
		

]

{ #category : #accessing }
PLTemplateList >> selectedCategory [

	^ categoryList selectedItem
]

{ #category : #accessing }
PLTemplateList >> selectedImage [
	
	^ templateTree selectedItem
]

{ #category : #accessing }
PLTemplateList >> templateTree [
	
	^ templateTree
]

{ #category : #events }
PLTemplateList >> whenSelectionChangedDo: aBlock [

	templateTree whenSelectionChangedDo: aBlock
]
