"
I'm the command to create Pharo project image from Github pull request number. I expect the PR number on my input (as command argument).
I use PharoProject and InriaCI server to determine proper build artifact (image template) that was built previously by CI based on pull request triggered by author of PR.
"
Class {
	#name : #PhLImageCreateFromPullRequestCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	self addNewImageFlagTo: aCommandSpec.
	self addTemplateNameFlagTo: aCommandSpec.
	self addTemplateCategoryFlagTo: aCommandSpec.
"
	^ 
	{	
		self newImageFlag.
		self templateNameFlag.
		self templateCategoryFlag 	 
	}"
]

{ #category : #'command line - arguments' }
PhLImageCreateFromPullRequestCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	aCommandSpec 
		addPositional: #pullRequest 
		description: 'Github pull request number, from which will be image created. If missing, project with its baseline is used to determine correct template.'.
"

	^ {
		(ClapPositional id: #pullRequest)
			description: 'Github pull request number, from which will be image created. If missing, project with its baseline is used to determine correct template. ';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound 
				signal: self missingPullRequestArgMessage ];
			yourself.
		}"
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromPR
]

{ #category : #'command line' }
PhLImageCreateFromPullRequestCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on a Github pull request number from the successful build of Inria CI server used by Pharo project.'
]

{ #category : #'error signalling' }
PhLImageCreateFromPullRequestCliCommand class >> raiseMissingPullRequest [

	^ NotFound signal: 'An argument is missing. Please specify the pull request number to find the image template from Inria CI build.'
]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> cantFindImageTemplateMessage: imageFinder [

	^ 'Could not determine build artifact for pull request: {1} from Inria CI server. Either url is not reachable or connection to server was lost: "{2}".' 
		  format: { 
				  self pullRequestNumber.
				  imageFinder pullRequestBuildArtifactsUrlString }
]

{ #category : #'command execution' }
PhLImageCreateFromPullRequestCliCommand >> execute [

	self validatePullRequest.
	super execute

]

{ #category : #querying }
PhLImageCreateFromPullRequestCliCommand >> findTemplate [

	"find template from Inria CI server based on Pull request number"

	| imageFinder templateUrl |
	imageFinder := PhLImageFinder fromInriaCIPullRequest: self pullRequestNumber.
	[ templateUrl := imageFinder inriaCIArtifactUrl. ]
		on: PhLDownloadError
		do: [ :ex | PhLDownloadError signal:(self cantFindImageTemplateMessage: imageFinder) ].
	
	 ^ PhLRemoteTemplate
		  name: (self templateNameFrom: templateUrl)
		  url: templateUrl
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromPullRequestCliCommand >> pullRequestNumber [

	^ (arguments at: #pullRequest)
		value: self;
		word
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> templateNameFrom: url [
	"make sure that PR number is part of image template name"
	
	| name |
	name := super templateNameFrom: url.
	^ name
		  copyReplaceAll: '-PR-'
		  with: ('-PR-{1}-' format: { self pullRequestNumber })
]

{ #category : #private }
PhLImageCreateFromPullRequestCliCommand >> validatePullRequest [

	self pullRequestNumber isAllDigits 
		ifFalse: [ Error signal: ('Not a valid pull request number: {1}' format: { self pullRequestNumber  } )]

]
