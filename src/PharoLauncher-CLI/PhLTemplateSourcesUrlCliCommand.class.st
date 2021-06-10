"
I represent Pharo Template source Url sub-command invoked from cmd line of Pharo Launcher. My responsibility is to display the source of officials templates. 

I declare: 
- optional flag for stonOutput

I execute:
- gives the source the templates from the official category
"
Class {
	#name : #PhLTemplateSourcesUrlCliCommand,
	#superclass : #PhLTemplateCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line - converting' }
PhLTemplateSourcesUrlCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #sourcesUrl 
	 
]

{ #category : #initialization }
PhLTemplateSourcesUrlCliCommand >> execute [
   self sourcesUrlTemplate
]

{ #category : #initialization }
PhLTemplateSourcesUrlCliCommand >> sourcesUrlTemplate [
	| listTemplatesAvailableForDownload |
   listTemplatesAvailableForDownload := self templateRepository roots. 
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup name = 'Official distributions'  ].
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload children.
   listTemplatesAvailableForDownload do: [ :template | self outStream nextPutAll: template name. self outStream nextPutAll:': '. self outStream nextPutAll: (template url asString ). self outStream lf ]
]
