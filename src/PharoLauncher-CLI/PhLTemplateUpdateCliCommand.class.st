"
I represent Pharo Template update sub-command invoked from cmd line of Pharo Launcher.
My responsibility is to update the list of templates from the official source.
"
Class {
	#name : #PhLTemplateUpdateCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - converting' }
PhLTemplateUpdateCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #update
]

{ #category : #'command execution' }
PhLTemplateUpdateCliCommand >> basicExecute [

	self registerOnTemplateSourcesUpdate.
	PhLPharoTemplateSources fromFile checkForUpdates.
	self pharoLauncherModel resetTemplateRepository.
]

{ #category : #updating }
PhLTemplateUpdateCliCommand >> registerOnTemplateSourcesUpdate [

	PhLPharoTemplateSources announcer weak
		when: PhLSourcesFileUpdateAvailable
		send: #updateTemplateSources
		to: self.
]

{ #category : #updating }
PhLTemplateUpdateCliCommand >> updateTemplateSources [
		
	PhLPharoTemplateSources fromFile updateSourcesFile
]
