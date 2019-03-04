Class {
	#name : #PhLLaunchConfigurationFormTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testChangeCommandInputKeepsSameModel [

	| form originalModel |
	form := PhlLaunchConfigurationFormPresenter new.
	originalModel := form model.
	
	form commandInput type: 'blalbalba'.

	self assert: form model identicalTo: originalModel
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testChangeLaunchConfigurationFormModelShowsNewConfigurationCommand [

	| newCommand form newModel |
	form := PhlLaunchConfigurationFormPresenter on: PhlLaunchConfiguration new.

	newCommand := 'new command'.
	newModel := PhlLaunchConfiguration new
		command: newCommand;
		yourself.

	form setModel: newModel.
	
	self assert: form commandInput text equals: newCommand
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testChangeLaunchConfigurationFormModelShowsNewConfigurationName [

	| newName form newModel |
	form := PhlLaunchConfigurationFormPresenter on: PhlLaunchConfiguration new.

	newName := 'new name'.
	newModel := PhlLaunchConfiguration new
		name: newName;
		yourself.
		
	form setModel: newModel.
	
	self assert: form nameInput text equals: newName
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testEditLaunchConfigurationFormCommandUpdatesModel [

	| form newCommand |
	form := PhlLaunchConfigurationFormPresenter new.
	
	newCommand := 'new command'.
	form commandInput type: newCommand.

	self assert: form model command equals: newCommand
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testEditLaunchConfigurationFormNameUpdatesModel [

	| form newName |
	form := PhlLaunchConfigurationFormPresenter new.
	
	newName := 'new name'.
	form nameInput type: newName.

	self assert: form model name equals: newName
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testLaunchConfigurationFormShowsConfigurationCommand [

	| command form |
	command := '{vm} {image} new test'.
	form := PhlLaunchConfigurationFormPresenter on: (PhlLaunchConfiguration command: command).
	
	self assert: form commandInput text equals: command
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testLaunchConfigurationFormShowsConfigurationName [

	| name form |
	name := 'test'.
	form := PhlLaunchConfigurationFormPresenter on: (PhlLaunchConfiguration named: name).
	
	self assert: form nameInput text equals: name
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testNewLaunchConfigurationFormHasDefaultLaunchConfigurationCommand [

	| form |
	form := PhlLaunchConfigurationFormPresenter new.	
	self assert: form commandInput text equals: PhlLaunchConfiguration defaultCommand
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testNewLaunchConfigurationFormHasEmptyText [

	| form |
	form := PhlLaunchConfigurationFormPresenter new.	
	self assert: form nameInput text isEmpty
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testOpenLaunchConfigurationDoesNotFail [

	"Smoke test"
	PhlLaunchConfigurationFormPresenter new openWithSpec close
]
