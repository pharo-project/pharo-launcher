"
I'm the command to create image from Github pull request number. I expect the PR number on my input (as command argument).
If repository full name isn't specified, I use Pharo as my default GH project and I create image based on SHA of PR branch parent. 
I can also create image from PR based on different GH project than Pharo, but then I use latest stable version of Pharo as template instead. I install project based on identified branch using Metacello command. 

"
Class {
	#name : #PhLImageCreateFromPullRequestCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#instVars : [
		'headRepo',
		'remoteBranch'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromPR
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on a Github pull request number from remote repository.'
]

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdFlags [

	^ 
	{	self repositoryFlag. 
		self subfolderFlag.
		self newImageFlag.
		self templateNameFlag.
		self templateCategoryFlag 	 
	}
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdPositionals [

	^ {
		(ClapPositional id: #pullRequest)
			description: 'Github pull request number, from which will be image created.';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound 
				signal: 'Argument not found. Please specify pull request number of Github project.'];
			yourself.
		}
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> missingRepoArgMessage [
	
	^ 'An argument is missing. Please specify the Github repository full name in {owner}/{project} format.'
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> missingSubfolderArgMessage [

	^ 'An argument is missing. Please specify the sub-folder (e.g. ''src'') with source code.'

]

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> repositoryFlag [

	^ (ClapFlag id: #repository)
			description: 'Github Repository full name (e.g. {owner}/{project}), from which PR will be obtained. By default ''pharo-project/pharo'' is used.';
			meaning: [ :arg :app | "this argument is optional "
				(arg at: #repositoryArg) value];
			implicitMeaning: [ :arg :app | app implicitRepository ];
			add: ((ClapPositional id: #repositoryArg)
					description: 'Repository argument in owner/project format.';
					meaning: [ :pos | pos word asString ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingRepoArgMessage]);
			yourself
]

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> subfolderFlag [

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
PhLImageCreateFromPullRequestCliCommand >> baselineName [

	^ (self headRepo copyAfterLast: $/) capitalized 
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> directoryVersionNumber [
	
	^ self pharoVersionNumber, '0'
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> execute [

	|anImage|
	self validatePullRequest.
	self validateRepoFullName.
	anImage := self findTemplateAndCreateImage.
	self getHeadRepoAndBranchName.
	self loadPullRequestCodeToImage: anImage.
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> findTemplate [
	"find template defined by user"
	self templateName ifNotNil: [ ^ self findUserTemplate ].

	"for pharo-project use latest development template"
	self usingDefaultPharoProject
		ifTrue: [ ^ self latestDevTemplate ].

	"otherwise latest stable Pharo version template"
	^ self latestStableTemplate
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> getClientForUrl: anUrl [

	|client| 
	client := PhLDownloadManager default newHTTPClientForUrl: anUrl.
	client 
		accept: ZnMimeType applicationJson;
		contentReader: [ :entity | STONJSON fromString: entity contents ];
		ifFail: [ :exception | self error: exception messageText  ].
	^ client
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> getHeadRepoAndBranchName [
	|aClient prResponse |
	aClient := self getClientForUrl: self pullRequestUrl. 
	self logPullRequestDetails.
	PhLDownloadManager default displayProgressDuring: [prResponse := aClient get ].
	self headRepo: (self headRepoFullNameFrom: prResponse).
	self remoteBranch: (self headBranchNameFrom: prResponse).
	self logHeadRepoAndRemoteBranch.
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> getPullRequestLoadConfigFor: anImage [

	|aConfig|
	aConfig := PhLLaunchConfiguration defaultWithImage: anImage.
	aConfig name: 'Lauch configuration for loading project from the pull request.'.
	aConfig vmArguments: self launchVmArguments.
	aConfig imageArguments: self remoteRepoProjectLoadArguments.
	^ aConfig
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> headBranchNameFrom: prResponse [

	^ (prResponse at: #head) at: #ref

]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> headRepo [

	^ headRepo
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> headRepo: aRepoName [

	headRepo := aRepoName
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> headRepoFullNameFrom: prResponse [
	
	^ ((prResponse at: #head) at: #repo) at: #full_name
]

{ #category : #default }
PhLImageCreateFromPullRequestCliCommand >> implicitRepository [

	"by default use Pharo project from which will be PR identified"
	^ 'pharo-project/pharo'
]

{ #category : #default }
PhLImageCreateFromPullRequestCliCommand >> implicitSubfolder [

	"by default use 'src' as subfolder for sources"
	^ 'src'
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> launchVmArguments [

	"Use headless argument for now, check availability on platform"
	^ OrderedCollection with: '--headless'
	
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> loadPullRequestCodeToImage: anImage [

	|imageConfig |
	imageConfig := self getPullRequestLoadConfigFor: anImage.
	self logLoadingPullRequestUsing: imageConfig commandString.
	"anImage launchWithConfiguration: imageConfig."
	
	"use handled execution and wait for result"
	imageConfig launchProcess runAndWaitWithStdOutput.
	self logLoadingFinished: anImage.
	
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logHeadRepoAndRemoteBranch [

	self logInfoMessage: ('Identified remote branch: {1}.' format: { self remoteBranch } ).
	self logInfoMessage: ('Head repository: {1}.' format: {self headRepo })
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> logLoadingFinished: anImage [

	self logInfoMessage: ('Loading project and branch: {1}:{2} into image: {3} finished successfully!' format: { self headRepo. self remoteBranch. anImage name} )
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> logLoadingPullRequestUsing: cmdString [

	self logInfoMessage: ('Loading code from pull request into image using command:' format: { cmdString } ).
	self logInfoMessage: 'This can take several minutes...'
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logPullRequestDetails [

	self logInfoMessage: ('Getting Pull request details from GH remote repository: {1}, pull request: {2}...' format: { self repoFullName. self pullRequestNumber.  })
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> mcLoadProjectFromPR [
	^ '"Iceberg remoteTypeSelector: #httpsUrl. Metacello new baseline: ''{1}''; repository: ''{2}:{3}/{4}''; onConflictUseIncoming; load"' 
	format: { 
		self baselineName. 
		('github://', self headRepo). 
		self remoteBranch. 
		self sourcesSubFolder.
	}

]

{ #category : #'accessing - arguments' }
PhLImageCreateFromPullRequestCliCommand >> pullRequestNumber [

	^ (arguments at: #pullRequest)
		value: self;
		word
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> pullRequestUrl [
	
	^ 'https://api.github.com/repos/{1}/pulls/{2}' format: {self repoFullName. self pullRequestNumber. }
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> remoteBranch [

	^ remoteBranch
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> remoteBranch: aBranchName [

	remoteBranch := aBranchName
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> remoteBranchUrl [
	
	^ 'https://api.github.com/repos/{1}/branches/{2}' format: {self headRepo. self remoteBranch. }
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> remoteRepoProjectLoadArguments [

		^ OrderedCollection 
			with: 'eval' 
			with: '--save' 
			with: self mcLoadProjectFromPR
			
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromPullRequestCliCommand >> repoFullName [

	^ self flagValueFor: #repository
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> sourcesSubFolder [

	^ self flagValueFor: #subfolder
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> usingDefaultPharoProject [

	^ self repoFullName = self implicitRepository
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> validatePullRequest [

	self pullRequestNumber isAllDigits ifFalse: [ Error signal: ('Not a valid pull request number: {1}' format: { self pullRequestNumber  } )]

]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> validateRepoFullName [

	"should match {alphanumeric-chars with dash}/{alphanumeric-chars with dash}"
	(self repoFullName matchesRegex: '[\w]+-?[\w]+\/[\w]+-?[\w]+') ifFalse: [Error signal:( 'Invalid repository name: {1}. Please specify in {owner/project} format.' format: {self repoFullName } )]
]
