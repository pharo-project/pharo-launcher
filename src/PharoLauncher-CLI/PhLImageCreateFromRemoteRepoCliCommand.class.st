"
I'm the command to create image based on specified template (using latest stable template implicitly). Additionally, I load into created image Github project based on specified CLI repo argument and baseline name.
"
Class {
	#name : #PhLImageCreateFromRemoteRepoCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> addBaselineFlagTo: aCommandSpec [

	aCommandSpec 
		addFlag: #baseline 
		description: 'Specifies the project baseline to be loaded by Metacello command. If not specified, baseline is determined from repository name.' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app baselineNameFromRepoName ] ].
	
	"^ (ClapFlag id: #baseline)
			description: 'Specifies the project baseline to be loaded by Metacello command. If not specified, baseline is determined from repository name. ';
			meaning: [ :arg :app | (arg at: #baselineArg) value];
			implicitMeaning: [ :arg :app |  ];
			add: ((ClapPositional id: #baselineArg)
					description: 'Baseline argument.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingBaselineArgMessage]);
			yourself "
]

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	self addNewImageFlagTo: aCommandSpec.
	self addTemplateNameFlagTo: aCommandSpec.
	self addTemplateCategoryFlagTo: aCommandSpec.
	self addSubfolderFlagTo: aCommandSpec.
	self addBaselineFlagTo: aCommandSpec.

"
	^ 
	{	
		self newImageFlag.
		self templateNameFlag.
		self templateCategoryFlag.
		self subfolderFlag.
		self baselineFlag.
	}"
]

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #repository 
		description: 'Github Repository full name (e.g. {owner}/{project} or {owner}/{project}:{branchOrTag}), from which will be project loaded (based on baseline) into created image.'.
"
	^ {
		(ClapPositional id: #repository)
			description: 'Github Repository full name (e.g. {owner}/{project} or {owner}/{project}:{branchOrTag}), from which will be project loaded (based on baseline) into created image.';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound signal: self missingRepoArgMessage];
			yourself.
		}"
]

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> addSubfolderFlagTo: aCommandSpec [
	
	aCommandSpec 
		addFlag: #subfolder 
		description: 'The sub-folder containing the code. By default ''''src'''' sub-folder is used.' 
		positionalSpec: [ :positional | positional	defaultValue: [ :arg :app | app implicitSubfolder ] ].
"
	^ (ClapFlag id: #subfolder)
			description: 'The sub-folder containing the code. By default ''src'' sub-folder is used. ';
			meaning: [ :arg :app | ""this argument is optional ""
				(arg at: #subfolderArg) value];
			implicitMeaning: [ :arg :app | app implicitSubfolder ];
			add: ((ClapPositional id: #subfolderArg)
					description: 'Subfolder argument.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingSubfolderArgMessage]);
			yourself "
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromRepo
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on a template and loads user defined project from Github remote repository into image.'
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> missingBaselineArgMessage [

	^ 'An argument is missing. Please specify the Baseline name to load project into Pharo image.'

]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> missingRepoArgMessage [
	
	^ 'An argument is missing. Please specify the Github repository full name in {owner}/{project} format.'
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> missingSubfolderArgMessage [

	^ 'An argument is missing. Please specify the sub-folder (e.g. ''src'') with source code.'

]

{ #category : #'accessing - arguments' }
PhLImageCreateFromRemoteRepoCliCommand >> baselineFlag [

	^ self positional: #baseline
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> baselineName [
	
	"use flag, otherwise determine baseline from repo name"
	^ self baselineFlag ifNil: [ self baselineNameFromRepoName ]
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> baselineNameFromRepoName [

	^ ((self repoFullName findBetweenSubstrings: #( '/' ':') ) second copyReplaceAll: '-' with: ' ') asCamelCase 
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> execute [

	|anImage| 
	self validateRepoFullName.
	anImage := self findTemplateAndCreateImage.
	self loadPullRequestCodeToImage: anImage
	

]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> getPullRequestLoadConfigFor: anImage [

	^ (PhLLaunchConfiguration defaultWithImage: anImage)
		  name: 'Lauch configuration for loading project from the pull request.';
		  vmArguments: self launchVmArguments;
		  imageArguments: self remoteRepoProjectLoadArguments
]

{ #category : #default }
PhLImageCreateFromRemoteRepoCliCommand >> implicitSubfolder [

	"by default use 'src' as subfolder for sources"
	^ 'src'
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> isValidRepoFullName [

	^ self repoFullName matchesRegex: self regexForRepoName
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> launchVmArguments [

	"Use headless argument for now, check availability on platform"
	^ OrderedCollection with: '--headless'
	
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> loadPullRequestCodeToImage: anImage [

	|imageConfig |
	imageConfig := self getPullRequestLoadConfigFor: anImage.
	self logLoadingPullRequestUsing: self mcLoadProjectFromRepo.
	
	"use handled execution and wait for result"
	imageConfig launchProcess runAndWaitWithStdOutput.
	self logLoadingFinished: anImage.
	
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> logLoadingFinished: anImage [

	self 
		logInfoMessage: ('Loading of project: {1}/{2} into image: {3} finished successfully!' 
		format: { self repoFullName. self sourcesSubFolder. anImage name} )
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> logLoadingPullRequestUsing: cmdString [

	self logInfoMessage: ('Loading code from Github remote repository into image using command: {1}.' format: { cmdString } ).
	self logInfoMessage: 'This can take several minutes...'
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> mcLoadProjectFromRepo [
	^ '"Iceberg remoteTypeSelector: #httpsUrl. Metacello new baseline: ''{1}''; repository: ''{2}/{3}''; onConflictUseIncoming; load"' 
	format: { 
		self baselineName. 
		('github://', self repoFullName). 
		self sourcesSubFolder.
	}

]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> regexForRepoName [
	|stringWithDash|

	"e.g. some-project-123"
	stringWithDash := '[\w]+-?[\w]+'.
	
	"should match {alphanumeric-chars with dash}/{alphanumeric-chars with dash}:{feature}/{alphanumeric-chars with dash}"
	^ stringWithDash, '\/', stringWithDash, '(\:?', stringWithDash, '(\/', stringWithDash, ')?', ')?'
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> remoteRepoProjectLoadArguments [

		^ OrderedCollection 
			with: 'eval' 
			with: '--save' 
			with: self mcLoadProjectFromRepo
			
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromRemoteRepoCliCommand >> repoFullName [

   ^ (arguments at: #repository)
		value: self;
		word 

]

{ #category : #'accessing - arguments' }
PhLImageCreateFromRemoteRepoCliCommand >> sourcesSubFolder [

	^ self positional: #subfolder
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> validateRepoFullName [

	"should match {alphanumeric-chars with dash}/{alphanumeric-chars with dash}:{alphanumeric-chars with dash}, which is owner/project:tagOrBranch"
	self isValidRepoFullName ifFalse: [Error signal:( 'Invalid repository name: {1}. Please specify in \{owner\}/\{project\} or \{owner\}/\{project\}:\{feature\}/\{branch-name\} format.' format: { self repoFullName } )]
]
