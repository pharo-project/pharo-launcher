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

{ #category : #'command line - arguments' }
PhLImageCreateFromBuildCliCommand class >> addLauncherFlagsTo: aCommandSpec [

	self addPharoVersionFlagTo: aCommandSpec.
	self addNewImageFlagTo: aCommandSpec.
]

{ #category : #'command line - arguments' }
PhLImageCreateFromBuildCliCommand class >> addLauncherPositionalsTo: aCommandSpec [

	(aCommandSpec 
		addPositional: #buildNumber 
		description: 'Pharo build number, from which will be template found and image created.')
	implicitMeaning: [:arg :app | self raiseMissingBuildNumber]
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #fromBuild
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on a the build number contained in the Pharo development template.'
]

{ #category : #'error signalling' }
PhLImageCreateFromBuildCliCommand class >> raiseMissingBuildNumber [

	^ NotFound signal: 'An argument is missing. Please specify the Pharo build number to find the image template.'
]

{ #category : #'command execution' }
PhLImageCreateFromBuildCliCommand >> basicExecute [

	self validateBuildNumber.
	super basicExecute 
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromBuildCliCommand >> buildNumber [

  ^ self positional: #buildNumber
]

{ #category : #querying }
PhLImageCreateFromBuildCliCommand >> findTemplate [
	| url imageFinder |

	imageFinder := PhLImageFinder pharoVersion: self pharoVersionNumber build: self buildNumber.
	[ url := imageFinder findUrl asUrl. ]
		on: NotFound, PhLDownloadError  
		do: [ :ex | self raiseImageTemplateFromBuildNrNotFound].

	^ PhLRemoteTemplate name: (self templateNameFrom: url) url: url
]

{ #category : #'error signalling' }
PhLImageCreateFromBuildCliCommand >> raiseBuildNumberInvalid [

	^ PhLError signal: ('Not a valid build number: {1}' format: { self buildNumber })
]

{ #category : #'error signalling' }
PhLImageCreateFromBuildCliCommand >> raiseImageTemplateFromBuildNrNotFound [

	^ PhLDownloadError signal:
		  ('Could not determine remote image template from build number: {1} and version number: {2}.' 
			   format: { 
					   self buildNumber.
					   self pharoVersionNumber })
]

{ #category : #'accessing - arguments' }
PhLImageCreateFromBuildCliCommand >> sha [

	^ self positional: #sha
]

{ #category : #private }
PhLImageCreateFromBuildCliCommand >> validateBuildNumber [

	self buildNumber isAllDigits ifFalse: [self raiseBuildNumberInvalid]
]
