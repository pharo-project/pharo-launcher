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
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLTemplateSourcesDirCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #sourcesDir 

	
]

{ #category : #initialization }
PhLTemplateSourcesDirCliCommand >> execute [
   self outStream nextPutAll: self templateRepository localTemplatesDirectory asString. self outStream newLine
]
