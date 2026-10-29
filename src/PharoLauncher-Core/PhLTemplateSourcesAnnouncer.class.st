"
Shared announcer used to notify listeners (typically the UI application) about changes in the Pharo Launcher
template sources without requiring PharoLauncher-Core to depend on a concrete application.
"
Class {
	#name : 'PhLTemplateSourcesAnnouncer',
	#superclass : 'Announcer',
	#classVars : [
		'DefaultInstance'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'singleton' }
PhLTemplateSourcesAnnouncer class >> default [

	^ DefaultInstance ifNil: [ DefaultInstance := self new ]
]
