"
asCliCommand

	^ self newLauncherCommand: #fromTemplate
"
Class {
	#name : #PhLImageCreateFromTemplateCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateFromTemplateCliCommand class >> asCliCommand [

	^ self newLauncherCommand: #fromTemplate
]

{ #category : #'command line' }
PhLImageCreateFromTemplateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image on local computer from remote site based on template name.'
]

{ #category : #'command line - arguments' }
PhLImageCreateFromTemplateCliCommand class >> launcherCmdFlags [

	^ {
		self templateCategoryFlag.
		self newImageFlag. 
	}			
			
]

{ #category : #'command line' }
PhLImageCreateFromTemplateCliCommand class >> launcherCmdPositionals [

	^ {
		(ClapPositional id: #templateName)
				description: 'Template which will be used to create the image.';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app | app defaultTemplate ];
					yourself
	}
]

{ #category : #'command line - arguments' }
PhLImageCreateFromTemplateCliCommand class >> repositoryFlag [

	^ (ClapFlag id: #repository)
			description: 'Github Repository full name (e.g. {owner}/{project}), from which PR will be obtained.';
			meaning: [ :arg :app | "this argument is optional "
				(arg at: #repositoryArg) value];
			implicitMeaning: [ :arg :app | app implicitRepository ];
			add: ((ClapPositional id: #repositoryArg)
					description: 'Repository argument in owner/project format.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingRepoArgMessage]).
]

{ #category : #'command line - arguments' }
PhLImageCreateFromTemplateCliCommand class >> templateCategoryFlag [

	^  (ClapFlag id: #templateCategory)
				description: 'Specifies the template category to search the target template.';
				meaning: [  :arg :app | (arg at: #templateCategoryArg) value ];
				implicitMeaning: [  :arg :app | app defaultTemplateCategoryName ];
				add: ((ClapPositional id: #templateCategoryArg)
					description: 'Template category argument.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app |  app defaultTemplateCategoryName]);
				yourself 
					
			
]

{ #category : #'command execution' }
PhLImageCreateFromTemplateCliCommand >> execute [
	
	self findTemplateAndCreateImage 
]
