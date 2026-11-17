Class {
	#name : 'PhLScriptPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'application',
		'scriptFolder',
		'file',
		'window'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'running' }
PhLScriptPresenterTest >> setUp [
	super setUp.
	scriptFolder := FileSystem memory root.
	file := (scriptFolder / 'foo.st') ensureCreateFile.
	self setUpPresenter.
]

{ #category : 'running' }
PhLScriptPresenterTest >> setUpPresenter [
	application := PhLTestApplication new.
	presenter := PhLScriptPresenter
		             newApplication: application
		             model: scriptFolder.
]

{ #category : 'running' }
PhLScriptPresenterTest >> tearDown [ 
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : 'tests' }
PhLScriptPresenterTest >> testCanAddNewScript [
	self
		assert: scriptFolder files size 
		equals: 1.
		
	ITUserInteraction
		useBackend: (ITTestBackend answering: 'bar.st')
		during: [ presenter clickAddScriptButton ].
		
	self
		assert: scriptFolder files size
		equals: 2.
	self assert: (scriptFolder / 'foo.st') exists.
]

{ #category : 'tests' }
PhLScriptPresenterTest >> testCanRemoveScript [
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

{ #category : 'tests' }
PhLScriptPresenterTest >> testCanSaveScript [

	presenter selectScript: file.
	presenter fileEditor text: 'bar'.
	
	presenter saveSelectedScript.
		
	self
		assert: file contents
		equals: 'bar'.
]

{ #category : 'tests' }
PhLScriptPresenterTest >> testCannotAddScriptWithAnExistingName [

	self
		should: [
			ITUserInteraction
				useBackend: (ITTestBackend answering: 'foo.st')
				during: [ presenter clickAddScriptButton ] ]
		raise: ITInvalidAnswer
]

{ #category : 'tests' }
PhLScriptPresenterTest >> testCannotRemoveScriptIfNoneSelected [

	self
		assert: scriptFolder files size 
		equals: 1.
		
	presenter clickRemoveScriptButton.
		
	self
		assert: scriptFolder files size
		equals: 1.
]

{ #category : 'tests' }
PhLScriptPresenterTest >> testNewScriptEndsWithStExtension [

	self
		assert: scriptFolder files size 
		equals: 1.
		
	ITUserInteraction
		useBackend: (ITTestBackend answering: 'bar')
		during: [ presenter clickAddScriptButton ].
		
	self
		assert: scriptFolder files size
		equals: 2.
	self assert: (scriptFolder / 'bar.st') exists.
]

{ #category : 'tests' }
PhLScriptPresenterTest >> testSaveScriptUsingKeybind [
	presenter selectScript: file.
	presenter fileEditor text: 'bar'.
	window := presenter open.
	
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
