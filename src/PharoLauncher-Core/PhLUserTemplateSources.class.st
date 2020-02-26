"
I represent the template sources defined by the user locally and used by Pharo Launcher.

Preview :
	PhLTemplateGroupsBuilder buildFrom: PhLUserTemplateSources fromUserFile.
"
Class {
	#name : #PhLUserTemplateSources,
	#superclass : #PhLTemplateSources,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #example }
PhLUserTemplateSources class >> example [ 
	^ self withTemplateList:  
		{ PhLTemplateSource new 	
			type: PhLTemplateSource httpListingType;
			name: 'User-defined http listing'; 
			url: 'http://myserver.org/myimages/';
			yourself }
]

{ #category : #accessing }
PhLUserTemplateSources class >> fromFile [
	^ self withFile: self sourcesFile
]

{ #category : #accessing }
PhLUserTemplateSources class >> sourcesFile [
	"File with the list of user-defined templates sources for Pharo Launcher"
	^ self launcherCoreDir / 'mysources.list'
]
