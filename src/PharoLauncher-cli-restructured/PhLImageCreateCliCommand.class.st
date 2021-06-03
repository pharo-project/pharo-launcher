"
I represent Pharo Image create sub-command invoked from cmd line of Pharo Launcher. My responsibility is to create new local images within Pharo launcher based on specified template. 

I declare: 
- mandatory positional with existing image template name, based on new image is created
- optional flag for specifying new image name (other than default)

I execute:
- create new local image based on specified image template name with new name specified as flag
"
Class {
	#name : #PhLImageCreateCliCommand,
	#superclass : #PhLImageCliCommand,
	#instVars : [
		'repository'
	],
	#category : #'PharoLauncher-cli-restructured'
}

{ #category : #'command line' }
PhLImageCreateCliCommand class >> asCliCommand: aPharoLauncherModel [
	^ self newLauncherCommand: #create launcherModel: aPharoLauncherModel
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image on local computer from remote site based on template name.'
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdPositionals [

	^ {((ClapPositional id: #templateName)
				description: 'Template which will be used to create the image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | app  ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'New image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | app  ];
					yourself)	
	}
]

{ #category : #accessing }
PhLImageCreateCliCommand >> createImage: aTemplateName to:newImageName [
   | listTemplatesAvailableForDownload templateToDownload|
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup name = 'Official distributions'  ].
   templateToDownload := listTemplatesAvailableForDownload children detect: [ :aTemplate | aTemplate name = aTemplateName ].
   
    repository extractTemplate: templateToDownload to: newImageName 
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> execute [
  
   self createImage: self templateName to: self imageName
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [ 
   ^ (arguments at: #newImageName) word
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateName [ 
  ^ (arguments at: #templateName) word


]
