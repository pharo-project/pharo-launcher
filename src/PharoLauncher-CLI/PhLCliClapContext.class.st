"
Context used in the tests in order to set the apropriate pharo launcher model. In production mode the clap context is used and the launcher model used is the default one. 
"
Class {
	#name : #PhLCliClapContext,
	#superclass : #ClapContext,
	#instVars : [
		'launcherModel'
	],
	#category : #'PharoLauncher-CLI-Model'
}

{ #category : #initialization }
PhLCliClapContext >> initialize [

	super initialize.

	"initialize default notification center with proper streams available on context object"
	PhLNotificationCenter default outStream: self stdout.
	PhLNotificationCenter default errorStream: self stderr.
]

{ #category : #initialization }
PhLCliClapContext >> launcherModel [
	^ launcherModel ifNil: [ launcherModel := PharoLauncherCLIModel new ]
]

{ #category : #initialization }
PhLCliClapContext >> launcherModel: aModel [
	launcherModel := aModel
]
