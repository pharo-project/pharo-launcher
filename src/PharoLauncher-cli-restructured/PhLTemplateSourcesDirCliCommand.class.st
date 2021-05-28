"
I represent Pharo Template source directory sub-command invoked from cmd line of Pharo Launcher. My responsibility is to display the source directory of templates. 

I declare: 
- optional flag for stonOutput

I execute:
- gives the source directory of the templates
"
Class {
	#name : #PhLTemplateSourcesDirCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line - converting' }
PhLTemplateSourcesDirCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #sourcesDir launcherModel: aPharoLauncherModel

	
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> execute [
   self outputSourcesDirectoryTemplate.
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> outputSourcesDirectoryTemplate [
   self outStream nextPutAll: self pharoLauncherModel templateBaseRepository localTemplatesDirectory asString. self outStream cr. 
]
