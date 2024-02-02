"
A context used in Pharo Launcher CLI tests.
It allows to use a Pharo launcher model for tests (using images and templates from memory store). 
The default context will instantiate a new `PharoLauncherCLIModel` while I can return a predefined pharo launcher model.
"
Class {
	#name : #PhLCliTestClapContext,
	#superclass : #ClapContext,
	#instVars : [
		'launcherModel'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
PhLCliTestClapContext >> command [ 

	^ super command
		pharoLauncherModel: launcherModel;
		yourself
]

{ #category : #initialization }
PhLCliTestClapContext >> initialize [ 

	super initialize.
	launcherModel := PharoLauncherCLIModel fromDefaultConfiguration.
]

{ #category : #accessing }
PhLCliTestClapContext >> pharoLauncherModel [

	^ launcherModel
]
