Class {
	#name : #PhLScriptPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'application',
		'scriptFolder',
		'file'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #running }
PhLScriptPresenterTest >> setUp [
	super setUp.
	scriptFolder := FileSystem memory root.
]

{ #category : #running }
PhLScriptPresenterTest >> setUpPresenter [
	application := PhLTestApplication new.
	presenter := PhLScriptPresenter
		             newApplication: application
		             model: scriptFolder.
	presenter fileEditor adapter: (SpMorphicTextAdapter adapt: presenter fileEditor).
]

{ #category : #tests }
PhLScriptPresenterTest >> testCanAddNewScript [
	self setUpPresenter.
	application requestAnswer: 'foo.st'.
	self
		assert: scriptFolder files size 
		equals: 0.
		
	presenter clickAddScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 1.
	self assert: (scriptFolder / 'foo.st') exists.
]

{ #category : #tests }
PhLScriptPresenterTest >> testCanRemoveScript [
	| file |
	file := (scriptFolder / 'foo.st') ensureCreateFile.
	self setUpPresenter.
	self
		assert: scriptFolder files size 
		equals: 1.
		
	presenter 
		selectScript: file;
		clickRemoveScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 0.
]

{ #category : #tests }
PhLScriptPresenterTest >> testCanSaveScript [
	| file |
	file := (scriptFolder / 'foo.st') ensureCreateFile.
	self setUpPresenter.
	presenter selectScript: file.
	presenter fileEditor text: 'bar'.
	
	presenter saveSelectedScript.
		
	self
		assert: file contents
		equals: 'bar'.
]

{ #category : #tests }
PhLScriptPresenterTest >> testCannotRemoveScriptIfNoneSelected [
	self setUpPresenter.
	(scriptFolder / 'foo') ensureCreateFile.
	self
		assert: scriptFolder files size 
		equals: 1.
		
	presenter clickRemoveScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 1.
]

{ #category : #tests }
PhLScriptPresenterTest >> testNewScriptEndsWithStExtension [
	self setUpPresenter.
	application requestAnswer: 'foo'.
	self
		assert: scriptFolder files size 
		equals: 0.
		
	presenter clickAddScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 1.
	self assert: (scriptFolder / 'foo.st') exists.
]

{ #category : #tests }
PhLScriptPresenterTest >> testSaveScriptUsingKeybind [
	file := (scriptFolder / 'foo.st') ensureCreateFile.
	self setUpPresenter.
	presenter selectScript: file.
	presenter fileEditor text: 'bar'.
	
	presenter fileEditor adapter
		keyDown: $s
		shift: false 
		meta: true
		control: false
		option: false.
		
	self
		assert: file contents
		equals: 'bar'.
]
