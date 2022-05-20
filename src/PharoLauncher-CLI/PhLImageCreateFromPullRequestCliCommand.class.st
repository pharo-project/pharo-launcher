"
I'm the command to create image from Github pull request number. I expect the PR number on my input (as command argument).
If repository full name isn't specified, I use Pharo as my default GH project and I create image based on SHA of PR branch parent. 
I can also create image from PR based on different GH project than Pharo, but then I use latest stable version of Pharo as template instead. I install project based on identified branch using Metacello command. 

"
Class {
	#name : #PhLImageCreateFromPullRequestCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#instVars : [
		'ghResponse'
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
PhLImageCreateFromPullRequestCliCommand class >> pharoVersionFlag [ 

"use latest development Pharo version"
^ super 
	pharoVersionFlag
	implicitMeaning: [ :arg :app | app implicitPharoVersion];
	yourself
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

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> findTemplate [ 
	|aClient prResponse headRepo headBranchName|
	aClient := self getClientForUrl: self pullRequestUrl. 
	self getAndLogPRResponse: [prResponse := aClient get ].
	headRepo := self headRepoFullNameFrom: prResponse.
	headBranchName := self headBranchNameFrom: prResponse.
	self logHeadRepoAndBranchDetails: {headRepo. headBranchName. }
	
		"parentSHA := self parentSHAFrom: prResponse."
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> getAndLogPRResponse: getResponseBlock [

	self logPullRequestDetails.
	PhLDownloadManager default displayProgressDuring: getResponseBlock value.
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
PhLImageCreateFromPullRequestCliCommand >> headBranchNameFrom: prResponse [
	
	^ ((prResponse at: #head) at: #repo) at: #full_name
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> headRepoFullNameFrom: prResponse [
	
	^ (prResponse at: #head) at: #ref
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromPullRequestCliCommand >> implicitRepository [

	"by default use Pharo project from which will be PR identified"
	^ 'pharo-project/pharo'
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logHeadRepoAndBranchDetails: formatArray [

	self logInfoMessage: ('Identified branch: {1}, head repository: {2} from pull request.' format: formatArray)
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> logPullRequestDetails [

	self logInfoMessage: ('Getting Pull request details form GH remote repository: {1}, pull request: {2}.' format: { self repoFullName. self pullRequestNumber.  })
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromPullRequestCliCommand >> pullRequestNumber [

	^ self flagValueFor: #pullRequest
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromPullRequestCliCommand >> pullRequestUrl [
	
	^ 'api.github.com/repos/{1}/pulls/{2}' format: {self repoFullName. self pullRequestNumber. }
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromPullRequestCliCommand >> remoteBranchUrl [
	
	^ 'api.github.com/repos/{1}/branches/{2}' format: {self repoFullName. self headBranchName. }
]

{ #category : #'as yet unclassified' }
PhLImageCreateFromPullRequestCliCommand >> repoFullName [

	^ self flagValueFor: #repository
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
