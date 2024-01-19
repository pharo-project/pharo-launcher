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
	#instVars : [
		'imageFinderClass'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addNoLaunchFlagTo: aCommandSpec.
	self addTemplateNameFlagTo: aCommandSpec.
	self addTemplateCategoryFlagTo: aCommandSpec.
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #newImageName 
		description: 'Name of the new Pharo image.')
	implicitMeaning: [:arg :app | self raiseNewImageNotFound]
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addNewImageFlagTo: aCommandSpec [
	
	aCommandSpec 
		addFlag: #newImageName 
		description: 'Name of the new Pharo image (template name is used by default).' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app implicitImageName ] ]
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addNoLaunchFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #'no-launch' 
		description: 'When flag is present, the just created image will not be launched after its creation.'
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addPharoVersionFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #pharoVersion 
		description: 'Version of Pharo to be downloaded.' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app implicitPharoVersion ]]
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addTemplateCategoryFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #templateCategory 
		description: 'Specifies the template category to search the target template.'
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app defaultTemplateCategoryName ]]
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> addTemplateNameFlagTo: aCommandSpec [

	aCommandSpec 
		addFlagWithPositional: #templateName 
		description: 'Template which will be used to create the image'
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #create 
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image on local computer from remote site based on template name (latest stable template is used by default).'
]

{ #category : #'error signalling' }
PhLImageCreateCliCommand class >> raiseMissingPharoVersion [

	^ NotFound signal: 'An argument is missing. Please specify Pharo version.'
]

{ #category : #'error signalling' }
PhLImageCreateCliCommand class >> raiseMissingTemplateName [

	^ NotFound signal: 'An argument is missing. Please specify Pharo template name.'
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> basicExecute [
	| image |
	
	image := self findTemplateAndCreateImage.
	self shouldLaunchImage
		ifTrue: [ image launch ]
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

{ #category : #querying }
PhLImageCreateCliCommand >> findTemplate [ 

	"find template defined by user"
	(self hasFlag: #templateName) ifTrue: [ ^ self findUserTemplate ].
	
	"otherwise latest stable Pharo version template"
	^ self latestStableTemplate
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> findTemplateAndCreateImage [

	"return newly created image"
	^ self createImage: self imageName from: self findTemplate
]

{ #category : #querying }
PhLImageCreateCliCommand >> findUserTemplate [

	^ [ self findUserTemplateFromName ]
		on: NotFound 
		do: [ self findUserTemplateFromShortName ]
]

{ #category : #querying }
PhLImageCreateCliCommand >> findUserTemplateFromName [

	^ self templateRepository
		templateNamed: self templateName
		inCategoryNamed: self templateCategory

]

{ #category : #querying }
PhLImageCreateCliCommand >> findUserTemplateFromShortName [

	^ self templateRepository
		templateShortNamed: self templateName
		inCategoryNamed: self templateCategory

]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageFinderClass [

	^ imageFinderClass ifNil: [ PhLImageFinder ]
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageFinderClass: aClass [
	
	imageFinderClass := aClass
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [

	^ self positional: #newImageName
]

{ #category : #default }
PhLImageCreateCliCommand >> implicitImageName [

	^ self findTemplate name
]

{ #category : #default }
PhLImageCreateCliCommand >> implicitPharoVersion [

	^ self imageFinderClass findLatestPharoDevelopmentVersion
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

	^ self positional: #pharoVersion
]

{ #category : #asserting }
PhLImageCreateCliCommand >> shouldLaunchImage [
	^ (self hasFlag: #'no-launch') not
]

{ #category : #querying }
PhLImageCreateCliCommand >> template [ 
	^ self templateRepository
		templateNamed: self templateName
		inCategoryNamed: self templateCategory
		
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategory [

	^ self positional: #templateCategory
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategoryName [ 

		^ self positional: #templateCategoryName
]

{ #category : #private }
PhLImageCreateCliCommand >> templateNameFrom: url [
	^ url lastPathSegment copyUpToLast: $.
]
