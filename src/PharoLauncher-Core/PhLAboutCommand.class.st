"
Command to display a box with information related to the Pharo Launcher
"
Class {
	#name : #PhLAboutCommand,
	#superclass : #PhLGeneralCommand,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #versions }
PhLAboutCommand class >> version: aString [

	LauncherVersion := aString.
]

{ #category : #querying }
PhLAboutCommand >> aboutText [
	^ String streamContents: [:stream |
		stream
			<< 'Pharo Launcher version: ';
			<< self launcherVersion;
			cr; cr;
			<< 'Pharo Launcher is a tool that eases the management of Pharo images and their associated Virtual Machines. It can download official Pharo images from the Pharo repository, fetch the right virtual machine to run your image and many other things.';
			cr;
			<< 'Documentation is available at https://pharo-project.github.io/pharo-launcher.';
			cr;
			<< 'If you find a bug, please open an issue at https://github.com/pharo-project/pharo-launcher/issues.'.
 ]
	
]

{ #category : #converting }
PhLAboutCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #help;
		shortcutKey: (KeyboardKey named: 'QUESTION') meta;
		yourself
]

{ #category : #executing }
PhLAboutCommand >> execute [
	| presenter |
	presenter := PhLAboutPresenter 
		text: self aboutText
		iconName: #pharo.
	presenter application: self application.
	
	presenter openDialog.
	^ presenter
]

{ #category : #initialization }
PhLAboutCommand >> initialize [
	super initialize.
	self
		name: 'About';
		description: 'Documentation and information about Pharo Launcher'
]

{ #category : #querying }
PhLAboutCommand >> launcherVersion [

	^ LauncherVersion ifNil: [ 'N/A' ] 
]
