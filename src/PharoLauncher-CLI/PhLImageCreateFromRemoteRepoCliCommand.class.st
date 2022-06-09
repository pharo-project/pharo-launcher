Class {
	#name : #PhLImageCreateFromRemoteRepoCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromRepo
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on a template and loads user defined project from Github remote repository into image.'
]

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> launcherCmdFlags [

	^ 
	{	
		self newImageFlag.
		self templateNameFlag.
		self templateCategoryFlag.
		self subfolderFlag.
	}
]

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> launcherCmdPositionals [

	^ {
		(ClapPositional id: #repository)
			description: 'Github Repository full name (e.g. {owner}/{project} or {owner}/{project}:{branchOrTag}), from which will be project loaded (based on baseline) into created image.';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound signal: self missingRepoArgMessage];
			yourself.
		}
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> missingRepoArgMessage [
	
	^ 'An argument is missing. Please specify the Github repository full name in {owner}/{project} format.'
]

{ #category : #'command line' }
PhLImageCreateFromRemoteRepoCliCommand class >> missingSubfolderArgMessage [

	^ 'An argument is missing. Please specify the sub-folder (e.g. ''src'') with source code.'

]

{ #category : #'command line - arguments' }
PhLImageCreateFromRemoteRepoCliCommand class >> subfolderFlag [

	^ (ClapFlag id: #subfolder)
			description: 'The sub-folder containing the code. By default ''src'' sub-folder is used. ';
			meaning: [ :arg :app | "this argument is optional "
				(arg at: #subfolderArg) value];
			implicitMeaning: [ :arg :app | app implicitSubfolder ];
			add: ((ClapPositional id: #subfolderArg)
					description: 'Subfolder argument.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingSubfolderArgMessage]);
			yourself 
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> baselineName [

	^ (self headRepo copyAfterLast: $/) capitalized 
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

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> launchVmArguments [

	"Use headless argument for now, check availability on platform"
	^ OrderedCollection with: '--headless'
	
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> loadPullRequestCodeToImage: anImage [

	|imageConfig |
	imageConfig := self getPullRequestLoadConfigFor: anImage.
	self logLoadingPullRequestUsing: imageConfig commandString.
	"anImage launchWithConfiguration: imageConfig."
	
	"use handled execution and wait for result"
	imageConfig launchProcess runAndWaitWithStdOutput.
	self logLoadingFinished: anImage.
	
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> logLoadingFinished: anImage [

	self 
		logInfoMessage: ('Loading project and branch: {1}:{2} into image: {3} finished successfully!' 
		format: { self headRepo. self remoteBranch. anImage name} )
]

{ #category : #'command execution' }
PhLImageCreateFromRemoteRepoCliCommand >> logLoadingPullRequestUsing: cmdString [

	self logInfoMessage: ('Loading code from pull request into image using command:' format: { cmdString } ).
	self logInfoMessage: 'This can take several minutes...'
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> mcLoadProjectFromPR [
	^ '"Iceberg remoteTypeSelector: #httpsUrl. Metacello new baseline: ''{1}''; repository: ''{2}:{3}/{4}''; onConflictUseIncoming; load"' 
	format: { 
		self baselineName. 
		('github://', self headRepo). 
		self remoteBranch. 
		self sourcesSubFolder.
	}

]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> remoteRepoProjectLoadArguments [

		^ OrderedCollection 
			with: 'eval' 
			with: '--save' 
			with: self mcLoadProjectFromPR
			
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromRemoteRepoCliCommand >> repoFullName [

	^ self flagValueFor: #repository
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromRemoteRepoCliCommand >> sourcesSubFolder [

	^ self flagValueFor: #subfolder
]

{ #category : #private }
PhLImageCreateFromRemoteRepoCliCommand >> validateRepoFullName [

	"should match {alphanumeric-chars with dash}/{alphanumeric-chars with dash}"

	(self repoFullName matchesRegex: '[\w]+-?[\w]+\/[\w]+-?[\w]+') 
		ifFalse: [ 
			Error signal:
				('Invalid repository name: {1}. Please specify in {owner/project} format.' format: { self repoFullName }) ]
]
