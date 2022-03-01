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
		'remoteBranch',
		'parentSHA'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromPR
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdFlags [

	^ 
	{	self repositoryFlag. 
		self pharoVersionFlag.
		self newImageFlag.
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

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> repositoryFlag [

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

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> createImage: newImageName from: template [

	self logCreationOfImageFrom: template name.
	self logInfoMessage: 'Done!'
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> directoryVersionNumber [
	
	^ self pharoVersionNumber, '0'
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> execute [
	
	self findTemplateAndCreateImage
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> findLatestDevelopmentTemplate [

	|templateUrl|
	templateUrl := ('https://files.pharo.org/image/{1}/stable-64.zip' format: { self directoryVersionNumber }) asUrl.
	self logRemoteTemplateUrl: templateUrl asString. 
	^ PhLRemoteTemplate name: self defaultTemplate url: templateUrl.
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> findTemplate [ 

	self getHeadRepoAndBranchName.
	self getParentSHA.
	^ [ 	|templateUrl imageFinder|
		imageFinder := PhLImageFinder pharoVersion: self pharoVersionNumber sha: self shortSHA.
		templateUrl := imageFinder findUrl asUrl.
		self logRemoteTemplateUrl: templateUrl asString. 
		PhLRemoteTemplate name: imageFinder findTemplateName url: templateUrl.
	] 
	on: Error 
	do: 
	[	self logNotFoundDevTemplate.
		self findLatestDevelopmentTemplate 
	]
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

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> getParentSHA [
	|aClient aResponse |
	aClient := self getClientForUrl: self remoteBranchUrl. 
	self logParentSHAdetails.
	PhLDownloadManager default displayProgressDuring: [aResponse := aClient get ].
	self parentSHA: (self parentSHAFrom: aResponse).
	self logParentSHA.

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

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logHeadRepoAndRemoteBranch [

	self logInfoMessage: ('Identified remote branch: {1}.' format: { self remoteBranch } ).
	self logInfoMessage: ('Head repository: {1}.' format: {self headRepo })
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logNotFoundDevTemplate [

	self logInfoMessage: 'Could not determine development image template from parent SHA. Using latest development version template.'
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logParentSHA [

	self logInfoMessage: ('Identified parent commit SHA of remote branch: {1}.' format: { self parentSHA  } )

]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logParentSHAdetails [

	self logInfoMessage: 'Getting parent SHA commit from remote branch...'
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logPullRequestDetails [

	self logInfoMessage: ('Getting Pull request details from GH remote repository: {1}, pull request: {2}...' format: { self repoFullName. self pullRequestNumber.  })
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logRemoteTemplateUrl: urlString [

	self logInfoMessage: ('Identified remote template to download: {1}.' format: { urlString  } )

]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> mcLoadProjectFromPR [
	^ '"Metacello new baseline: ''PharoLauncher''; repository: ''{1}:{2}''; onConflictUseIncoming; load"'

]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> parentSHA [

	^ parentSHA
]

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> parentSHA: aSHAstring [

	parentSHA := aSHAstring
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> parentSHAFrom: aResponse [
	|parentCommit|
	parentCommit := ((aResponse at: #commit) at: #parents) first.
	^ parentCommit at: #sha
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

{ #category : #accessing }
PhLImageCreateFromPullRequestCliCommand >> shortSHA [

	^ parentSHA first: 7
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
