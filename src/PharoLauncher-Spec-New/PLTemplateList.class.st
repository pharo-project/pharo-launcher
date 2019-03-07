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

"	^ SpecBoxLayout newHorizontal 
		add: #categoryList;
		add: #templateTree;
		yourself
"	
	^ SpecBoxLayout newHorizontal 
		add: (SpecScrollableLayout with: #categoryList);
		add: (SpecScrollableLayout with: #templateTree);
		yourself
]

{ #category : #accessing }
PLTemplateList >> categoryList [

	^ categoryList
]

{ #category : #initialization }
PLTemplateList >> initializePresenter [

	categoryList items: self model categories.

	categoryList
		whenSelectionChangedDo: [ :selection | 
			templateTree roots: selection selectedItem children ]
]

{ #category : #initialization }
PLTemplateList >> initializeWidgets [

	categoryList := self newList.
	templateTree := self newTreeTable.
	
	templateTree 
		addColumn: (StringTableColumn evaluated: #printString);
		hideColumnHeaders 

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
