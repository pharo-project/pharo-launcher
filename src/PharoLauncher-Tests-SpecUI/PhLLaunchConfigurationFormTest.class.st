Class {
	#name : #PhLLaunchConfigurationFormTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testChangeLaunchConfigurationFormModelShowsNewConfigurationCommand [

	| newName form newModel |
	form := PhlLaunchConfigurationForm on: PhlLaunchConfiguration new.

	newName := 'new command'.
	newModel := PhlLaunchConfiguration new
		command: newName;
		yourself.
		
	form
		model: newModel;
		refreshModel.
	
	self assert: form commandInput text equals: newName
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testChangeLaunchConfigurationFormModelShowsNewConfigurationName [

	| newName form newModel |
	form := PhlLaunchConfigurationForm on: PhlLaunchConfiguration new.

	newName := 'new name'.
	newModel := PhlLaunchConfiguration new
		name: newName;
		yourself.
		
	form
		model: newModel;
		refreshModel.
	
	self assert: form nameInput text equals: newName
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testEditLaunchConfigurationFormCommandUpdatesModel [

	| form newCommand |
	form := PhlLaunchConfigurationForm new.
	
	newCommand := 'new command'.
	form commandInput type: newCommand.

	self assert: form model command equals: newCommand
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testEditLaunchConfigurationFormNameUpdatesModel [

	| form newName |
	form := PhlLaunchConfigurationForm new.
	
	newName := 'new name'.
	form nameInput type: newName.

	self assert: form model name equals: newName
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testLaunchConfigurationFormShowsConfigurationCommand [

	| command form |
	command := '{vm} {image} new test'.
	form := PhlLaunchConfigurationForm on: (PhlLaunchConfiguration command: command).
	
	self assert: form commandInput text equals: command
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testLaunchConfigurationFormShowsConfigurationName [

	| name form |
	name := 'test'.
	form := PhlLaunchConfigurationForm on: (PhlLaunchConfiguration named: name).
	
	self assert: form nameInput text equals: name
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testNewLaunchConfigurationFormHasDefaultLaunchConfigurationCommand [

	| form |
	form := PhlLaunchConfigurationForm new.	
	self assert: form commandInput text equals: PhlLaunchConfiguration defaultCommand
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testNewLaunchConfigurationFormHasEmptyText [

	| form |
	form := PhlLaunchConfigurationForm new.	
	self assert: form nameInput text isEmpty
]

{ #category : #tests }
PhLLaunchConfigurationFormTest >> testOpenLaunchConfigurationDoesNotFail [

	"Smoke test"
	PhlLaunchConfigurationForm new openWithSpec close
]
