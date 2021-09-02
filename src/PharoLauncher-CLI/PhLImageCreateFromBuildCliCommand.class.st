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
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #createFromBuild 
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdDescription [
	^ 'Downloads and creates new image on local computer from remote site based on a Pharo version number a build number and a SHA (would be better without but not possible for the moment) .'
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #build)
				description: 'Flag to precise the build to download ';
				meaning: [ :arg :app | (arg at: #buildNumber) word ];
				implicitMeaning: [ :arg :app | nil ];
				add: ((ClapPositional id: #buildNumber)
					description: 'Number if build to use';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [ :arg :app | nil ]).
		 (ClapFlag id: #sha)
				description: 'Flag to precise the sha to download';
				meaning: [ :arg :app | (arg at: #shaString) word ];
				implicitMeaning: [ :arg :app | nil ];
				add: ((ClapPositional id: #shaString)
					description: 'Sha used to find the image to download.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [  :arg :app | nil ]).
		(ClapFlag id: #pharoVersion)
				description: 'version of Pharo you want to download';
				meaning: [ :arg :app | (arg at: #pharoVersion) word ];
				implicitMeaning: [ :arg :app | NotFound signal: self missingPharoVersionFlagMessage ];
				add: ((ClapPositional id: #pharoVersion)
					description: 'version of Pharo you want to download.';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | NotFound signal: self missingPharoVersionFlagMessage ])
		}
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdPositionals [
	^ {
		((ClapPositional id: #newImageName)
				description: 'name of the new image';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |  ];
					yourself)
	}
]

{ #category : #logging }
PhLImageCreateFromBuildCliCommand class >> missingOrDuplicatedBuildNumberOrShaMessage [
	^ 'you need to specify either a Pharo image build number or a Pharo image SHA (only one of them)'
]

{ #category : #logging }
PhLImageCreateFromBuildCliCommand class >> missingPharoVersionFlagMessage [
	^ 'you need to specify a Pharo version'
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> buildNumber [
  ^ (arguments at: #build) value: self
]

{ #category : #testing }
PhLImageCreateFromBuildCliCommand >> isCommandValid [
	(self shaString isNil and: [ self buildNumber isNil ]) ifTrue: [ ^ false ].
	(self shaString isNotNil and: [ self buildNumber isNotNil ]) ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> pharoVersionNumber [
	^  (arguments at: #pharoVersion) value: self
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> sha [
	^ (arguments at: #sha) word
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> shaString [ 
  ^ (arguments at: #sha) value: self
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> targetName [
	^ (arguments at: #newImageName) word
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> template [
	| url imageFinder |
	
	template ifNotNil: [ ^ template ].
	self isCommandValid
		ifFalse: [ NotFound signal: self class missingOrDuplicatedBuildNumberOrShaMessage ].
		
	imageFinder := self buildNumber 
		ifNil: [ PhLImageFinder pharoVersion: self pharoVersionNumber sha: self sha ]
		ifNotNil: [ PhLImageFinder pharoVersion: self pharoVersionNumber build: self buildNumber ].
	url := imageFinder findUrl asUrl.
			
	^ template := PhLRemoteTemplate name: self targetName url: url
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> templateName [
	^ self template name
]
