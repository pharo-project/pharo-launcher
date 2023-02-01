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

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addTemplateNameFlagTo: aCommandSpec.
	self addTemplateCategoryFlagTo: aCommandSpec.

"

^ {
		self templateNameFlag.
		self templateCategoryFlag.
	}
"
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #newImageName 
		description: 'Name of the new Pharo image.'.
	

"
^ {
		(ClapPositional id: #newImageName)
				description: 'Name of the new Pharo image.';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingImageNameArgMessage];
					yourself
	}
"
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addNewImageFlagTo: aCommandSpec [
	
	aCommandSpec 
		addFlag: #newImageName 
		description: 'Name of the new Pharo image (template name is used by default).' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app implicitImageName ] ].
"
	^ (ClapFlag id: #newImageName)
			description: 'Name of the new Pharo image (template name is used by default).';
			meaning: [ :arg :app | 	(arg at: #newImageArg) value];
			""this argument is optional ""
			implicitMeaning: [ :arg :app | app implicitImageName];
			add: ((ClapPositional id: #newImageArg)
					description: 'New image argument.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app |  app implicitImageName]);
			yourself"
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addPharoVersionFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #pharoVersion 
		description: 'Version of Pharo to be downloaded.' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app implicitPharoVersion ]]
"
^ (ClapFlag id: #pharoVersion)
				description: 'Version of Pharo to be downloaded.';
				meaning: [ :arg :app | (arg at: #pharoVersionArg) value ];
				implicitMeaning: [ :arg :app | app implicitPharoVersion ];
				add: ((ClapPositional id: #pharoVersionArg)
					description: 'Specifies the version of Pharo you want to download.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingPharoVersionFlagMessage ]);
				yourself"
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addTemplateCategoryFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #templateCategory 
		description: 'Specifies the template category to search the target template.'
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app defaultTemplateCategoryName ]].
			
"^  (ClapFlag id: #templateCategory)
				description: 'Specifies the template category to search the target template.';
				meaning: [  :arg :app | (arg at: #templateCategoryArg) value ];
				implicitMeaning: [  :arg :app | app defaultTemplateCategoryName ];
				add: ((ClapPositional id: #templateCategoryArg)
					description: 'Template category argument.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app |  app defaultTemplateCategoryName]);
				yourself"
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addTemplateNameFlagTo: aCommandSpec [

	aCommandSpec 
		addFlagWithPositional: #templateName 
		description: 'Template which will be used to create the image'.
"	^ (ClapFlag id: #templateName)
			description: 'Template which will be used to create the image.';
			meaning: [  :arg :app | (arg at: #templateNameArg) value ];
			implicitMeaning: [ :arg :app |  ];
			add: ((ClapPositional id: #templateNameArg)
					description: 'Template name argument.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingTemplateNameArgMessage]);
			yourself
"
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #create 
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image on local computer from remote site based on template name (latest stable template is used by default).'
]

{ #category : #logging }
PhLImageCreateCliCommand class >> missingImageNameArgMessage [

	^ 'An argument is missing. Please specify the name for the new Pharo image.'
]

{ #category : #logging }
PhLImageCreateCliCommand class >> missingPharoVersionFlagMessage [

	^ 'An argument is missing. Please specify Pharo version.'
]

{ #category : #logging }
PhLImageCreateCliCommand class >> missingTemplateNameArgMessage [

	^ 'An argument is missing. Please specify Pharo template name.'
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> createImage: newImageName from: template [

	| anImage |
	self logCreationOfImageFrom: template name.
	anImage := self imageRepository
		           extractTemplate: template
		           to: newImageName.
	self logInfoMessage: 'Done!'.
	^ anImage
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> execute [
	
	self findTemplateAndCreateImage 
]

{ #category : #querying }
PhLImageCreateCliCommand >> findTemplate [ 

	"find template defined by user"
	self templateName ifNotNil: [ ^ self findUserTemplate ].

	"otherwise latest stable Pharo version template"
	^ self latestStableTemplate
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> findTemplateAndCreateImage [
	| aTemplate |
	aTemplate := [self findTemplate]
			on: NotFound
			do: [ :error | ^ self logExceptionMessage: error messageText ].

	"return newly created image"
	^ self createImage: self imageName from: aTemplate
]

{ #category : #querying }
PhLImageCreateCliCommand >> findUserTemplate [ 

	^ self templateRepository
		templateNamed: self templateName
		inCategoryNamed: self templateCategory

]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [

	^ self flagValueFor: #newImageName
]

{ #category : #default }
PhLImageCreateCliCommand >> implicitImageName [

	^ self findTemplate name
]

{ #category : #default }
PhLImageCreateCliCommand >> implicitPharoVersion [

	^ PhLImageFinder findLatestPharoDevelopmentVersion
]

{ #category : #default }
PhLImageCreateCliCommand >> latestDevTemplate [
	
	"from default 'Official distributions' obtain latest development template"
	^ self defaultTemplateCategory latestDevelopmentTemplate
]

{ #category : #default }
PhLImageCreateCliCommand >> latestStableTemplate [
	
	"from default 'Official distributions' obtain latest Pharo version stable template"
	^ self defaultTemplateCategory latestStableTemplate
]

{ #category : #logging }
PhLImageCreateCliCommand >> logCannotFindTemplate: templateName [

	self errorStream
		nextPutAll:
			('Cannot find the image template: {1}, please check the image template name (or template category if you are using the category subcommand).' 
				 format: { templateName });
		newLine
]

{ #category : #logging }
PhLImageCreateCliCommand >> logCreationOfImageFrom: aTemplateName [

	self logInfoMessage:
		('Creating the local Pharo image based on template: {1}.' format: { aTemplateName }).
	self logInfoMessage: 'Please wait a moment.'
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

{ #category : #'command execution' }
PhLImageCreateCliCommand >> printSubCommandsHelp [

	arguments positionalValues isEmpty ifTrue:[
		(ClapDocumenter on: self outStream) explain: arguments parent specification
	]
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

{ #category : #private }
PhLImageCreateCliCommand >> templateNameFrom: url [
	^ url lastPathSegment copyUpToLast: $.
]
