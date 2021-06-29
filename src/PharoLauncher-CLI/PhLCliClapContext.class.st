"
Context used in the tests in order to set the apropriate pharo launcher model. In production mode the clap context is used and the launcher model used is the default one. 
"
Class {
	#name : #PhLCliClapContext,
	#superclass : #ClapContext,
	#instVars : [
		'launcherModel'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #initialization }
PhLCliClapContext >> launcherModel [
	^ launcherModel
]

{ #category : #initialization }
PhLCliClapContext >> launcherModel: aModel [
	launcherModel := aModel
]
