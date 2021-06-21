"
I represent Pharo Image create sub-command invoked from cmd line of Pharo Launcher. My responsibility is to create new local images within Pharo launcher based on specified template. 

I declare: 
- mandatory positional with existing image template name, based on new image is created
- optional flag for specifying new image name (other than default)

I execute:
- create new local image based on specified image template name with new name specified as flag

Utilisation:
Example of utilisation with templateToUse as your template choice and newImageName as the name of your new image:
Open your terminal in the directory containing the pharo executable. You need to know the path of this image.

-  If you want to use the default template which is the last stable pharo version :
./pharo -path/to/the/image/with/PharoLauncherCLI clap launcher image create newImageName 

- If your template is in the official distributions group:
./pharo -path/to/the/image/with/PharoLauncherCLI clap launcher image create newImageName templateToUse

- If your template is in an other category (here yourTemplateGroup):
./pharo -path/to/the/image/with/PharoLauncherCLI clap launcher image create newImageName templateToUse --templateCategory yourTemplateGroup



"
Class {
	#name : #PhLImageCreateCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCreateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #create 
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image on local computer from remote site based on template name.'
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #templateCategory)
				description: 'Allows to use a template categroy to search the target template ';
				meaning: [  :arg :app | (arg at: #templateCategoryName) word ];
				implicitMeaning: [  :arg :app | 'Official distributions'. ];
				add: ((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category variable.';
					meaning: [ :pos | pos word asSymbol halt. ];
					implicitMeaning: [  :arg :app | app halt. ])}
					
			
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdPositionals [

	^ {
		((ClapPositional id: #newImageName)
				description: 'New image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'one argument is missing' .   ];
					yourself)	.
		((ClapPositional id: #templateName)
				description: 'Template which will be used to create the image.';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app | app defaultTemplate ];
					yourself).
	}
]

{ #category : #accessing }
PhLImageCreateCliCommand >> createImage: aTemplateName to: newImageName [
	self outStream
		nextPutAll:
			' creation of on image based on: ' , aTemplateName
				, 'Please wait a moment';
		newLine.
	^ [ self imageRepository
		extractTemplate: self template
		to: newImageName ]
		on: NotFound
		do: [ self errorStream
				nextPutAll:
					'cant find the template, please check the template name or category if you are using the category subcommand. You can check that with the template commands';
				cr ]
]

{ #category : #'as yet unclassified' }
PhLImageCreateCliCommand >> defaultTemplate [
	^ self findLatestPharoStableVersionInALocation: (self defaultTemplateCategory templatesAndGroups) 
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> execute [
   self createImage: self templateName to: self imageName 
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [ 
   ^ (arguments at: #newImageName) word
]

{ #category : #default }
PhLImageCreateCliCommand >> officialTemplateRepository [
	| listTemplatesAvailableForDownload |
	listTemplatesAvailableForDownload := PhLTemplateGroupRepository
		default roots.
	listTemplatesAvailableForDownload := listTemplatesAvailableForDownload
		detect: [ :aGroup | aGroup name = self defaultTemplateCategoryName ].
	^ listTemplatesAvailableForDownload
]

{ #category : #querying }
PhLImageCreateCliCommand >> template [
	^ self templateRepository templateNamed: self templateName inCategoryNamed: self templateCategory
	
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategory [
  ^ (arguments at: #templateCategory) value: self
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategoryName [ 
   ^ (arguments at: #templateCategoryName) word
]
