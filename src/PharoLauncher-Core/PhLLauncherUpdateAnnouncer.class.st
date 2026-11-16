"
Shared announcer used to notify listeners (the UI application) about the checks of Pharo Launcher updates, without requiring PharoLauncher-Core to depend on them.
"
Class {
	#name : 'PhLLauncherUpdateAnnouncer',
	#superclass : 'Announcer',
	#classVars : [
		'DefaultInstance'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'singleton' }
PhLLauncherUpdateAnnouncer class >> default [

	^ DefaultInstance ifNil: [ DefaultInstance := self new ]
]
