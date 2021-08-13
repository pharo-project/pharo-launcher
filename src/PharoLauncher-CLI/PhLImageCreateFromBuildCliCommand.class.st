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
PhLImageCreateFromBuildCliCommand class >> launcherCmdPositionals [
	^ {
		((ClapPositional id: #pharoVersionNumber)
				description: 'the number of the Pharo version you want to use';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | NotFound 
        signal: 'one argument is missing, there is no Pharo version for the new image' .   ];
					yourself)	.
		((ClapPositional id: #build)
				description: 'build number of the template to download';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |  ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'name of the new image';
					meaning: [ :pos | pos  word ];
					implicitMeaning: [ :arg :app |  ];
					yourself)
	}
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> buildNumber [
	^ (arguments at: #build) word
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> pharoVersionNumber [
	^ (arguments at: #pharoVersionNumber) word
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> sha [
	^ (arguments at: #sha) word
]

{ #category : #accessing }
PhLImageCreateFromBuildCliCommand >> targetName [
	^ (arguments at: #newImageName) word
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> template [
	| url |
	url := (PhLImageFinder pharoVersion: self pharoVersionNumber build: self buildNumber) findUrl asUrl.
	^ PhLRemoteTemplate name: self targetName url: url.
	
	
]
