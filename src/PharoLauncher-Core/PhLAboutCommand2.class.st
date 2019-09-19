"
Command to display a box with information related to the Pharo Launcher
"
Class {
	#name : #PhLAboutCommand2,
	#superclass : #PhLGeneralCommand2,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #querying }
PhLAboutCommand2 >> aboutText [
	^ String streamContents: [:stream |
		stream
			<< 'Pharo Launcher version: ';
			<< self launcherVersion;
			cr; cr;
			<< 'Pharo Launcher is a tool that eases the management of Pharo images and their associated Virtual Machines. It can download official Pharo images from the Pharo repository, fetch the right virtual machine to run your image and many other things.';
			cr;
			<< 'If you find a bug, please open an issue at https://github.com/pharo-project/pharo-launcher/issues.'.
 ]
	
]

{ #category : #converting }
PhLAboutCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #help;
		shortcutKey: $? meta;
		yourself
]

{ #category : #executing }
PhLAboutCommand2 >> execute [
	| presenter |
	presenter := PhLAboutPresenter 
		text: self aboutText
		iconName: #pharo.
	presenter openDialogWithSpec.
	^ presenter
]

{ #category : #initialization }
PhLAboutCommand2 >> initialize [
	super initialize.
	self
		name: 'About';
		description: 'About Pharo Launcher'
]

{ #category : #querying }
PhLAboutCommand2 >> launcherVersion [

	^ LauncherVersion ifNil: [ 'N/A' ] 
]
