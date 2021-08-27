"
I'm the command you can use to build an image either from a Pharo build number or from a git SHA.
You need to specify the pharo version in which the Build number or SHA will be search.
Indeed this command list availables images for the given pharo distribution from the pharo file server and select the matching version according to the build number or SHA.
"
Class {
	#name : #PhLImageCreateFromBuildCliCommand,
	#superclass : #PhLImageCreateCliCommand,
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
				meaning: [  :arg :app | (arg at: #buildNumber) word ];
				implicitMeaning: [  :arg :app | 1 ];
				add: ((ClapPositional id: #nuildNumber)
					description: 'Number if build to use';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app | 1 ]).
		 (ClapFlag id: #sha)
				description: 'Flag to precise the sha to download';
				meaning: [  :arg :app | (arg at: #shaString) word ];
				implicitMeaning: [  :arg :app | 1 ];
				add: ((ClapPositional id: #shaString)
					description: 'Sha used to find the image to download.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app | 1 ]).
		(ClapFlag id: #pharoVersion)
				description: 'version of Pharo you want to download';
				meaning: [ :arg :app | (arg at: #pharoVersion) word ];
				implicitMeaning: [  :arg :app | NotFound signal: 'you need to specify a Pharo version' ];
				add: ((ClapPositional id: #pharoVersion)
					description: 'version of Pharo you want to download.';
					meaning: [ :pos | pos word asSymbol . ];
					implicitMeaning: [  :arg :app | NotFound signal: 'you need to specify a Pharo version'  ])
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

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> buildNumber [
  ^ (arguments at: #build) value: self
]

{ #category : #checking }
PhLImageCreateFromBuildCliCommand >> checkIfDoable [
	(self shaString + self buildNumber = 2 ) ifTrue: [ false ]
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> pharoVersionNumber [
	^ (arguments at: #pharoVersion) value: self
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
	| url |
	self checkIfDoable
		ifFalse: [ NotFound
				signal:
					'an Information is missing to proceed. The build number or the sha is needed.' ].
	url := self buildNumber = 1
		ifTrue: [ (PhLImageFinder pharoVersion: self pharoVersionNumber sha: self sha)
				findUrl asUrl ]
		ifFalse: [ (PhLImageFinder
				pharoVersion: self pharoVersionNumber
				build: self buildNumber) findUrl asUrl ].
	^ PhLRemoteTemplate name: self targetName url: url
]
