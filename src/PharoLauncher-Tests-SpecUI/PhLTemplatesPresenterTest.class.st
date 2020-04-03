Class {
	#name : #PhLTemplatesPresenterTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #tests }
PhLTemplatesPresenterTest >> testTemplatesPresenterClosesWhenClickingOnCreateImage [
	| presenter |
	
	presenter := PhLTestTemplatesPresenter new.
	presenter 
		createLocalTemplateNamed: 'Foo';
		selectCategory: 1;
		selectTemplateNamed: 'Foo';
		openWithSpec.
		
	self assert: presenter window isOpen.
	presenter clickOnCreateButton.

	self deny: presenter window isOpen
]
