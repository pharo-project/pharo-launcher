"
I'm the command you can use to build an image either from a Pharo build number or from a git SHA.
You need to specify the pharo version in which the Build number or SHA will be search.
Indeed this command list availables images for the given pharo distribution from the pharo file server and select the matching version according to the build number or SHA.
"
Class {
	#name : #PhLImageCreateFromBuildCliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#instVars : [
		'template'
	],
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromBuild
]

{ #category : #'command line - arguments' }
PhLImageCreateFromBuildCliCommand class >> buildNumberFlag [

^ (ClapFlag id: #build)
		description: 'Determines the build to download the image.';
		meaning: [ :arg :app | (arg at: #buildNumber) word ];
		implicitMeaning: [ :arg :app | nil ];
		add: ((ClapPositional id: #buildNumber)
					description: 'Number of build to use.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [ :arg :app | nil ])
		yourself
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdDescription [
	^ 'Downloads and creates new image on local computer from remote site based on a Pharo version number a build number and a SHA (would be better without but not possible for the moment) .'
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdFlags [
	
	^	{ 
			self buildNumberFlag.
			self shaFlag.
			self pharoVersionFlag.
			self newImageFlag.
		}
]

{ #category : #logging }
PhLImageCreateFromBuildCliCommand class >> missingOrDuplicatedBuildNumberOrShaMessage [
	^ 'you need to specify either a Pharo image build number or a Pharo image SHA (only one of them)'
]

{ #category : #'command line - arguments' }
PhLImageCreateFromBuildCliCommand class >> shaFlag [

	^ (ClapFlag id: #sha)
			description: 'Determines the SHA to download image.';
			meaning: [ :arg :app | (arg at: #shaString) word ];
			implicitMeaning: [ :arg :app | nil ];
			add: ((ClapPositional id: #shaString)
				description: 'SHA used to find the image to download.';
				meaning: [ :pos | pos word asSymbol ];
				implicitMeaning: [  :arg :app | nil ]);
			yourself
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromBuildCliCommand >> buildNumber [
  ^ (arguments at: #build) value: self
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> execute [
	
	self findTemplateAndCreateImage
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> findTemplate [
	| url imageFinder |

	self isCommandValid
		ifFalse: [ NotFound signal: self class missingOrDuplicatedBuildNumberOrShaMessage ].
		
	imageFinder := self buildNumber 
		ifNil: [ PhLImageFinder pharoVersion: self pharoVersionNumber sha: self sha ]
		ifNotNil: [ PhLImageFinder pharoVersion: self pharoVersionNumber build: self buildNumber ].
	url := imageFinder findUrl asUrl.

	^ PhLRemoteTemplate name: imageFinder findTemplateName url: url
]

{ #category : #testing }
PhLImageCreateFromBuildCliCommand >> isCommandValid [
	(self shaString isNil and: [ self buildNumber isNil ]) ifTrue: [ ^ false ].
	(self shaString isNotNil and: [ self buildNumber isNotNil ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromBuildCliCommand >> sha [
	^ (arguments at: #sha) word
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromBuildCliCommand >> shaString [ 
  ^ (arguments at: #sha) value: self
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromBuildCliCommand >> targetName [
	^ (arguments at: #newImageName) word
]
