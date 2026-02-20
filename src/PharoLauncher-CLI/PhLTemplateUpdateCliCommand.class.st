"
I represent Pharo Template update sub-command invoked from cmd line of Pharo Launcher.
My responsibility is to update the list of templates from the official source.
"
Class {
	#name : 'PhLTemplateUpdateCliCommand',
	#superclass : 'PhLTemplateCliCommand',
	#category : 'PharoLauncher-CLI-Commands',
	#package : 'PharoLauncher-CLI',
	#tag : 'Commands'
}

{ #category : 'command line - converting' }
PhLTemplateUpdateCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #update
]

{ #category : 'command line - description' }
PhLTemplateUpdateCliCommand class >> launcherCmdDescription [

	^ 'Update the sources.list file used by Pharo Launcher to list available templates.'
]

{ #category : 'command execution' }
PhLTemplateUpdateCliCommand >> basicExecute [

	PhLPharoTemplateSources fromFile checkForUpdates: self
]

{ #category : 'updating' }
PhLTemplateUpdateCliCommand >> sourcesFileUpdateAvailable [
		
	PhLPharoTemplateSources fromFile updateSourcesFile.
	self pharoLauncherModel resetTemplateRepository
]
