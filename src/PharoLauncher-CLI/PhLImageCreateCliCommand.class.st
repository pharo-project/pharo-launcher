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
./pharo-launcher image create newImageName 

- If your template is in the official distributions group:
./pharo-launcher image create newImageName templateToUse

- If your template is in an other category (here yourTemplateGroup):
./pharo-launcher image create newImageName templateToUse --templateCategory yourTemplateGroup

./pharo-launcher image create newImageName --build 90-1203
./pharo-launcher image create newImageName --sha 90-eab34

"
Class {
	#name : #PhLImageCreateCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #create 
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new Pharo image based on one sub-commands.'
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #templateCategory)
				description: 'Allows to use a template category to search the target template.';
				meaning: [  :arg :app | (arg at: #templateCategoryName) word ];
				implicitMeaning: [  :arg :app | app defaultTemplateCategoryName. ];
				add: ((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category variable.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app |  ]).}
					
			
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdPositionals [

	^ {
		((ClapPositional id: #newImageName)
				description: 'New image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |
						NotFound signal: 'An argument is missing. Please specify the name for the new image'. ];
					yourself)	.
		((ClapPositional id: #templateName)
				description: 'Template which will be used to create the image.';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app | app defaultTemplate ];
					yourself).
	}
]

{ #category : #logging }
PhLImageCreateCliCommand class >> missingPharoVersionFlagMessage [

	^ 'An argument is missing. Please specify Pharo version.'
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> newImageFlag [

	^ (ClapFlag id: #newImageName)
			description: 'Name of the new Pharo image (template name used by default).';
			meaning: [ :arg :app | 	(arg at: #newImageArg) value];
			"this argument is optional "
			implicitMeaning: [ :arg :app | app implicitImageName];
			add: ((ClapPositional id: #newImageArg)
					description: 'New image argument.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app |  app implicitImageName]);
			yourself
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> pharoVersionFlag [

^ (ClapFlag id: #pharoVersion)
				description: 'Version of Pharo to be downloaded.';
				meaning: [ :arg :app | (arg at: #pharoVersionArg) value ];
				implicitMeaning: [ :arg :app | NotFound signal: self missingPharoVersionFlagMessage ];
				add: ((ClapPositional id: #pharoVersionArg)
					description: 'Specifies the version of Pharo you want to download.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingPharoVersionFlagMessage ]);
				yourself
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> createImage: newImageName from: template [

	self logCreationOfImageFrom: template name.
	^ self imageRepository
		extractTemplate: template
		to: newImageName
]

{ #category : #default }
PhLImageCreateCliCommand >> defaultTemplate [
	^ self
		findLatestPharoStableVersionIn: self defaultTemplateCategory templatesAndGroups
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> execute [
	| aTemplate |
	aTemplate := [ self findTemplate ]
			on: NotFound
			do: [ :error | ^ self logExceptionMessage: error messageText ].
	self createImage: self imageName from: aTemplate
]

{ #category : #querying }
PhLImageCreateCliCommand >> findTemplate [ 

	^ self templateRepository
		templateNamed: self templateName
		inCategoryNamed: self templateCategory

]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> findTemplateAndCreateImage [
	| aTemplate |
	aTemplate := [ self findTemplate ]
			on: NotFound
			do: [ :error | ^ self logExceptionMessage: error messageText ].
	self createImage: self imageName from: aTemplate
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [
	^ (arguments at: #newImageName) word
]

{ #category : #logging }
PhLImageCreateCliCommand >> logCannotFindTemplate: templateName [

self errorStream
		nextPutAll: ('Cannot find the image template: {1}, please check the image template name (or template category if you are using the category subcommand).' format: {templateName});
		newLine
]

{ #category : #logging }
PhLImageCreateCliCommand >> logCreationOfImageFrom: aTemplateName [
	self outStream
		nextPutAll:
			('Creating the local Pharo image based on template: {1}.' format: {aTemplateName});
		newLine;
		nextPutAll:
				'Please wait a moment.';
		newLine
]

{ #category : #default }
PhLImageCreateCliCommand >> officialTemplateRepository [
	| templatesCategories listTemplatesAvailableForDownload |
	templatesCategories := PhLTemplateGroupRepository default roots.
	listTemplatesAvailableForDownload := templatesCategories
		detect: [ :aGroup | aGroup name = self defaultTemplateCategoryName ].
	^ listTemplatesAvailableForDownload
]

{ #category : #accessing }
PhLImageCreateCliCommand >> pharoVersionNumber [ 

	^ self flagValueFor: #pharoVersion
]

{ #category : #querying }
PhLImageCreateCliCommand >> template [ 
	^ self templateRepository
		templateNamed: self templateName
		inCategoryNamed: self templateCategory
		
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategory [
  ^ (arguments at: #templateCategory) value: self
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategoryName [ 
   ^ (arguments at: #templateCategoryName) word
]
