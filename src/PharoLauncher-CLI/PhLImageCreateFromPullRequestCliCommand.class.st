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

	^ 'Downloads and creates new image based on a Github pull request number from the successful build of Inria CI server used by Pharo project.'
]

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdFlags [

	^ 
	{	
		self newImageFlag.
		self templateNameFlag.
		self templateCategoryFlag 	 
	}
]

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdPositionals [

	^ {
		(ClapPositional id: #pullRequest)
			description: 'Github pull request number, from which will be image created. If missing, project with its baseline is used to determine correct template. ';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound 
				signal: self missingPullRequestArgMessage ];
			yourself.
		}
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> missingPullRequestArgMessage [

	^ 'An argument is missing. Please specify the pull request number to find the image template from Inria CI build.'
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> cantFindImageTemplateMessage: imageFinder [

	^ 'Could not determine build artifact for pull request: {1} from Inria CI server. Url not reachable: "{2}".' 
		  format: { 
				  self pullRequestNumber.
				  imageFinder inriaCIBuildArtifactLinkString }
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> execute [

	self validatePullRequest.
	super execute

]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> findTemplate [

	"find template from Inria CI server based on Pull request number"

	| imageFinder |
	imageFinder := PhLImageFinder fromInriaCIPullRequest:
		               self pullRequestNumber.
	[ 
	^ PhLRemoteTemplate
		  name: imageFinder findInriaCITemplateName
		  url: imageFinder inriaCIArtifactUrl 
	]
		on: PhLDownloadError
		do: [ :ex | 
			PhLDownloadError signal:
				(self cantFindImageTemplateMessage: imageFinder) ]
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromPullRequestCliCommand >> pullRequestNumber [

	^ (arguments at: #pullRequest)
		value: self;
		word
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> validatePullRequest [

	self pullRequestNumber isAllDigits ifFalse: [ Error signal: ('Not a valid pull request number: {1}' format: { self pullRequestNumber  } )]

]
