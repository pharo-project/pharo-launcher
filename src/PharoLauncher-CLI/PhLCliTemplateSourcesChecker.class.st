"
I'm responsible to check if there is an update of Template sources when running a command by command line
"
Class {
	#name : 'PhLCliTemplateSourcesChecker',
	#superclass : 'Object',
	#instVars : [
		'command'
	],
	#category : 'PharoLauncher-CLI-Model',
	#package : 'PharoLauncher-CLI',
	#tag : 'Model'
}

{ #category : 'instance creation' }
PhLCliTemplateSourcesChecker class >> forCommand: aPhLCliCommand [

	^ self new
		command: aPhLCliCommand;
		yourself
]

{ #category : 'updating' }
PhLCliTemplateSourcesChecker >> checkForUpdates [

	"Should only be used by commands requiring network for a better Ux.
	Uses the observer variant so that only this checker is notified: announcing on the shared
	PhLTemplateSourcesAnnouncer would also wake the GUI application, which answers an update
	with a modal dialog that would never be closed and thus block the command."
	PhLPharoTemplateSources checkForUpdates: self
]

{ #category : 'accessing' }
PhLCliTemplateSourcesChecker >> command: anObject [

	command := anObject
]

{ #category : 'events' }
PhLCliTemplateSourcesChecker >> sourcesFileUpdateAvailable [

	command notifyTemplateSourcesUpdateAvailable
]
