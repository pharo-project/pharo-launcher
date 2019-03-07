Class {
	#name : #PLCreateImageDialogPresenterTest,
	#superclass : #PLAbstractSpecTestCase,
	#instVars : [
		'templateRepository'
	],
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #tests }
PLCreateImageDialogPresenterTest >> setUp [ 

	super setUp.

	templateRepository := PhLTemplateGroupRepository newFromGroups: PhLTemplateGroupsBuilder build.
	
	instance := PLCreateImageDialogPresenter on: templateRepository.
	instance application: SpecApplication new.
	window := instance openWithSpec
]

{ #category : #tests }
PLCreateImageDialogPresenterTest >> testImageTypeComponentShown [
	
	self assert: (window hasPresenter: instance imageTypeList)
]

{ #category : #tests }
PLCreateImageDialogPresenterTest >> testNameInputFieldIsEmpty [

	self assert: instance nameInputField text isEmpty
]

{ #category : #tests }
PLCreateImageDialogPresenterTest >> testNameInputFieldIsShown [

	self assert: (window hasPresenter: instance nameInputField)
]

{ #category : #tests }
PLCreateImageDialogPresenterTest >> testNameInputLabelIsShown [

	self assert: (window hasPresenter: instance nameInputLabel)
]

{ #category : #tests }
PLCreateImageDialogPresenterTest >> testNameInputLabelLabel [

	self assert: instance nameInputLabel label equals: 'Name:'
]
