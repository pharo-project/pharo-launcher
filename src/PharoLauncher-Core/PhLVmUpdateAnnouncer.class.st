"
Shared announcer used to notify listeners (the UI application, the VM manager) about the checks of virtual machines updates, without requiring PharoLauncher-Core to depend on them.
"
Class {
	#name : 'PhLVmUpdateAnnouncer',
	#superclass : 'Announcer',
	#classVars : [
		'DefaultInstance'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'singleton' }
PhLVmUpdateAnnouncer class >> default [

	^ DefaultInstance ifNil: [ DefaultInstance := self new ]
]
