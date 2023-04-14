Class {
	#name : #PhLImageCreateFromSHACliCommand,
	#superclass : #PhLImageCreateCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line - arguments' }
PhLImageCreateFromSHACliCommand class >> addLauncherFlagsTo: aCommandSpec [
	
	self addPharoVersionFlagTo: aCommandSpec.
	self addNewImageFlagTo: aCommandSpec.
]

{ #category : #'command line - arguments' }
PhLImageCreateFromSHACliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #sha 
		description: 'Commit SHA (7 letters) of Pharo image development template, from which will be  image created.')
	implicitMeaning: [:arg :app | self raiseMissingSha]
]

{ #category : #'command line' }
PhLImageCreateFromSHACliCommand class >> asCliCommand [
	^ self newLauncherCommandSpec: #fromSHA
]

{ #category : #'command line' }
PhLImageCreateFromSHACliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on the commit SHA (7 letter string) of Pharo build process contained in the name of Pharo development template.'
]

{ #category : #'error signalling' }
PhLImageCreateFromSHACliCommand class >> raiseMissingSha [

	^ NotFound signal: 'An argument is missing. Please specify the commit SHA string to find the image template.'
]

{ #category : #'command execution' }
PhLImageCreateFromSHACliCommand >> basicExecute [ 

	self validateSha.
	super basicExecute
]

{ #category : #querying }
PhLImageCreateFromSHACliCommand >> findTemplate [

	| url imageFinder |
	imageFinder := self imageFinderClass
		               pharoVersion: self pharoVersionNumber
		               sha: self sha.
	[ url := imageFinder findUrl asUrl ]
		on: NotFound , PhLDownloadError
		do: [ :ex | self raiseCantFindImageTemplate].

	^ PhLRemoteTemplate name: (self templateNameFrom: url) url: url
]

{ #category : #'error signalling' }
PhLImageCreateFromSHACliCommand >> raiseCantFindImageTemplate [

	^ PhLDownloadError signal:
		  ('Could not determine remote image template from SHA: {1} and version number: {2}.' 
			   format: { 
					   self sha.
					   self pharoVersionNumber })
]

{ #category : #'error signalling' }
PhLImageCreateFromSHACliCommand >> raiseShaInvalid [

	^ PhLError signal: ('Not a valid sha string: {1}. Must be alphanumeric string of size 7 (e.g.: 5ce32be).' format: { self sha })
]

{ #category : #accessing }
PhLImageCreateFromSHACliCommand >> sha [
	
	^ self positional: #sha
]

{ #category : #private }
PhLImageCreateFromSHACliCommand >> validateSha [

	(self sha isAllAlphaNumerics and: [ self sha size = 7 ]) 
	ifFalse: [self raiseShaInvalid]
]
