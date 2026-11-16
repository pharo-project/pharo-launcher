"
Command to display a box with information related to the Pharo Launcher
"
Class {
	#name : 'PhLAboutCommand',
	#superclass : 'PhLGeneralCommand',
	#classVars : [
		'LauncherVersion'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'versions' }
PhLAboutCommand class >> launcherVersion [
	"The version of the running launcher, set when it is built, 'N/A' in a development image"

	^ LauncherVersion ifNil: [ 'N/A' ]
]

{ #category : 'versions' }
PhLAboutCommand class >> version [
	"The version set when the launcher was built, nil in a development image"

	^ LauncherVersion
]

{ #category : 'versions' }
PhLAboutCommand class >> version: aString [

	LauncherVersion := aString.
]

{ #category : 'querying' }
PhLAboutCommand >> aboutText [

	^ String streamContents: [:stream |
		stream
			<< 'Pharo Launcher version: '; << self launcherVersion; cr; 
			cr;
			<< 'Pharo Launcher is a tool that eases the management of Pharo images and their associated Virtual Machines. It can download official Pharo images from the Pharo repository, fetch the right virtual machine to run your image and many other things.'; cr;
			cr;
			<< 'Documentation is available at '; cr; 
			<< 'https://pharo-project.github.io/pharo-launcher.'; cr;
			cr;
			<< 'If you find a bug, please open an issue at'; cr; 
			<< 'https://github.com/pharo-project/pharo-launcher/issues.' ]
	
]

{ #category : 'converting' }
PhLAboutCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #help;
		shortcutKey: (KeyboardKey named: 'QUESTION') asKeyCombination actionModifier;
		yourself
]

{ #category : 'executing' }
PhLAboutCommand >> execute [
	| presenter |

	presenter := PhLAboutPresenter newApplication: self application.
	presenter text: self aboutText.
	presenter asDialogWindow 
		owner: self context window;
		open.

	^ presenter
]

{ #category : 'initialization' }
PhLAboutCommand >> initialize [
	super initialize.
	self
		name: 'About';
		description: 'Documentation and information about Pharo Launcher'
]

{ #category : 'querying' }
PhLAboutCommand >> launcherVersion [

	^ self class launcherVersion
]
