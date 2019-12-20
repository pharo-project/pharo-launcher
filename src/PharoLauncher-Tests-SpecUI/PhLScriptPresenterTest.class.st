Class {
	#name : #PhLScriptPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'application',
		'scriptFolder'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #running }
PhLScriptPresenterTest >> setUp [
	scriptFolder := FileSystem memory root.
	self setUpPresenter
]

{ #category : #running }
PhLScriptPresenterTest >> setUpPresenter [
	application := PhLTestApplication new.
	presenter := PhLScriptPresenter
		             newApplication: application
		             model: scriptFolder
]

{ #category : #tests }
PhLScriptPresenterTest >> testCanAddNewScript [
	application requestAnswer: 'foo'.
	self
		assert: scriptFolder files size 
		equals: 0.
		
	presenter clickAddScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 1.
	self assert: (scriptFolder / 'foo') exists.
]

{ #category : #tests }
PhLScriptPresenterTest >> testCanRemoveScript [
	| file |
	file := (scriptFolder / 'foo') ensureCreateFile.
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
	file := (scriptFolder / 'foo') ensureCreateFile.
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
	(scriptFolder / 'foo') ensureCreateFile.
	self
		assert: scriptFolder files size 
		equals: 1.
		
	presenter clickRemoveScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 1.
]
