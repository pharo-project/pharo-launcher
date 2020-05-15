Class {
	#name : #PhLImageCreationPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #running }
PhLImageCreationPresenterTest >> setUp [
	super setUp.
	presenter := PhLImageCreationPresenter
		newApplication:
			(PharoLauncherApplication new
				scriptsDirectory: FileSystem memory root;
				yourself)
]

{ #category : #tests }
PhLImageCreationPresenterTest >> testInitializationScriptListUpdatedWhenScriptPresenterDoChange [
	| scriptPresenter |
	self
		assert: presenter initializationScriptItems size
		equals: 1. "No script"
		
	scriptPresenter := presenter openScriptPresenter.
	scriptPresenter newScriptNamed: 'foo.st'.
		
	self
		assert: presenter initScriptPresenter listItems size
		equals: 2.
	self
		assert: presenter initScriptPresenter listItems second basename
		equals: 'foo.st'.
		
	scriptPresenter withWindowDo: #close.
]
