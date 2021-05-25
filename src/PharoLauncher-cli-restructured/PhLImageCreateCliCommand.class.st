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
PhLImageCreateCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #create
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

{ #category : #'command execution' }
PhLImageCreateCliCommand >> execute [
   | arg1 arg2 |
    
   arg1 := self templateName.
   arg2 := self imageName.
   self outputCreateImage: arg1 to: arg2.
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [ 
  ^arguments words at: 3.
]

{ #category : #accessing }
PhLImageCreateCliCommand >> initialize [

	repository := PhLDirectoryBasedImageRepository default.
]

{ #category : #accessing }
PhLImageCreateCliCommand >> outputCreateImage: aTemplateName to:newImageName [
   | listTemplatesAvailableForDownload templateToDownload|
   listTemplatesAvailableForDownload := PhLTemplateGroupRepository default roots. 
   listTemplatesAvailableForDownload := listTemplatesAvailableForDownload  detect: [:aGroup | aGroup name = 'Official distributions'  ].
   templateToDownload := listTemplatesAvailableForDownload children detect: [ :aTemplate | aTemplate name = aTemplateName ].
   
    repository extractTemplate: templateToDownload to: newImageName 
]

{ #category : #accessing }
PhLImageCreateCliCommand >> repository: aPhLMockImageRepository [ 
	repository := aPhLMockImageRepository
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateName [ 
  ^arguments words at: 2.
]
