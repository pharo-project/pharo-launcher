Class {
	#name : #PhLTemplatesPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #running }
PhLTemplatesPresenterTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	presenter := PhLTestTemplatesPresenter new.

]

{ #category : #running }
PhLTemplatesPresenterTest >> tearDown [
	presenter window ifNotNil: #close.
	super tearDown
]

{ #category : #tests }
PhLTemplatesPresenterTest >> testCanCreateImageIfOneTemplateSelected [
	presenter 
		createLocalTemplateNamed: 'Foo';
		selectCategory: 1;
		selectTemplateNamed: 'Foo';
		imageName: 'foo'.
	
	presenter clickOnCreateButton.
	
	self assert: presenter createButtonEnabled.
]

{ #category : #tests }
PhLTemplatesPresenterTest >> testCannotCreateImageIfNoTemplateSelected [
	presenter imageName: 'foo'.
	
	presenter clickOnCreateButton.
	
	self deny: presenter createButtonEnabled.
]

{ #category : #tests }
PhLTemplatesPresenterTest >> testTemplatesPresenterClosesWhenClickingOnCreateImage [
	presenter 
		createLocalTemplateNamed: 'Foo';
		selectCategory: 1;
		selectTemplateNamed: 'Foo';
		openWithSpec.
		
	self assert: presenter window isOpen.
	presenter clickOnCreateButton.

	self deny: presenter window isOpen
]
