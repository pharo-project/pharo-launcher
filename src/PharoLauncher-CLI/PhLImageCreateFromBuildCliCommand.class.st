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

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image based on a the build number contained in the Pharo development template.'
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdFlags [
	
	^	{ 
			self pharoVersionFlag.
			self newImageFlag.
		}
]

{ #category : #'command line - arguments' }
PhLImageCreateFromBuildCliCommand class >> launcherCmdPositionals [

	^ {
		(ClapPositional id: #buildNumber)
			description: 'Pharo build number, from which will be template found and image created.';
			meaning: [ :pos | pos  asString ];
			implicitMeaning: [ :arg :app | NotFound 
				signal: self missingBuildNrArgMessage];
			yourself.
		}
]

{ #category : #'command line' }
PhLImageCreateFromBuildCliCommand class >> missingBuildNrArgMessage [

	^ 'An argument is missing. Please specify the Pharo build number to find the image template.'
]

{ #category : #logging }
PhLImageCreateFromBuildCliCommand class >> missingOrDuplicatedBuildNumberOrShaMessage [
	^ 'you need to specify either a Pharo image build number or a Pharo image SHA (only one of them)'
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

	imageFinder := PhLImageFinder pharoVersion: self pharoVersionNumber build: self buildNumber.
	url := imageFinder findUrl asUrl.

	^ PhLRemoteTemplate name: imageFinder findTemplateName url: url
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
