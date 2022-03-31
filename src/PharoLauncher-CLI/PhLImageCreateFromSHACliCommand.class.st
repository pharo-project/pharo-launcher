Class {
	#name : #PhLImageCreateFromSHACliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageCreateFromSHACliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromSHA
]

{ #category : #'command line' }
PhLImageCreateFromSHACliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on the commit SHA (7 letter string) of Pharo build process contained in the name of Pharo development template.'
]

{ #category : #'command line - arguments' }
PhLImageCreateFromSHACliCommand class >> launcherCmdPositionals [

	^ {
		(ClapPositional id: #sha)
			description: 'Commit SHA (7 letters) of Pharo image development template, from which will be  image created.';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound 
				signal: self missingShaArgMessage];
			yourself.
		}
]

{ #category : #querying }
PhLImageCreateFromSHACliCommand >> findTemplate [

	| url imageFinder |
	imageFinder := PhLImageFinder pharoVersion: self pharoVersionNumber sha: self sha.
	url := imageFinder findUrl asUrl.

	^ PhLRemoteTemplate name: imageFinder findTemplateName url: url
]
