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
PhLImageCreateFromSHACliCommand class >> launcherCmdFlags [
	
	^	{ 
			self pharoVersionFlag.
			self newImageFlag.
		}
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

{ #category : #'command line' }
PhLImageCreateFromSHACliCommand class >> missingShaArgMessage [

	^ 'An argument is missing. Please specify the commit SHA string to find the image template.'
]

{ #category : #private }
PhLImageCreateFromSHACliCommand >> cantFindImageTemplateMessage [

	^ 'Could not determine remote image template from SHA: {1} and version number: {2}.' 
		  format: { 
				  self sha.
				  self pharoVersionNumber }
]

{ #category : #'command execution' }
PhLImageCreateFromSHACliCommand >> execute [

	self validateSha.
	super execute

]

{ #category : #querying }
PhLImageCreateFromSHACliCommand >> findTemplate [

	| url imageFinder |
	imageFinder := PhLImageFinder
		               pharoVersion: self pharoVersionNumber
		               sha: self sha.
	[ url := imageFinder findUrl asUrl ]
		on: NotFound , PhLDownloadError
		do: [ :ex | PhLDownloadError signal: self cantFindImageTemplateMessage ].

	^ PhLRemoteTemplate name: imageFinder findTemplateName url: url
]

{ #category : #private }
PhLImageCreateFromSHACliCommand >> notValidShaMessage [

	^ 'Not a valid sha string: {1}. Must be alphanumeric string of size 7 (e.g.: 5ce32be).' format: { self sha }
]

{ #category : #accessing }
PhLImageCreateFromSHACliCommand >> sha [
  ^ (arguments at: #sha)
		value: self;
		word
]

{ #category : #private }
PhLImageCreateFromSHACliCommand >> validateSha [

	(self sha isAllAlphaNumerics and: [ self sha size = 7 ]) ifFalse: [ 
		Error signal: self notValidShaMessage ]
]
