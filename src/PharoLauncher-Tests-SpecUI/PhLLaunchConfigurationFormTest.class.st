Class {
	#name : #PhLLaunchConfigurationFormTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-SpecUI'
}

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
