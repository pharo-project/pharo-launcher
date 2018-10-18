"
Command to display a box with information related to the Pharo Launcher
"
Class {
	#name : #PhLAboutCommand,
	#superclass : #PhLGeneralCommand,
	#instVars : [
		'project'
	],
	#classVars : [
		'LauncherVersion'
	],
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLAboutCommand class >> icon [
	^ self iconNamed: #help
]

{ #category : #accessing }
PhLAboutCommand class >> title [
	^ 'About'
]

{ #category : #querying }
PhLAboutCommand class >> version: anObject. [

	LauncherVersion := anObject.
]

{ #category : #accessing }
PhLAboutCommand >> aboutText [
	^ String streamContents: [:stream |
		stream
			<< 'Pharo Launcher is a tool that ease the management of Pharo images and their associated Virtual Machines. It can download official Pharo images from the Pharo repository, fetch the right virtual machine to run your image and many other things.';
			cr;
			<< 'If you find a bug, please open an issue at https://github.com/pharo-project/pharo-launcher/issues.';
			cr; cr;
			<< 'Pharo Launcher version: ';
			<< self launcherVersion ]
	
]

{ #category : #action }
PhLAboutCommand >> execute [
	AboutDialogWindow new
		text: self aboutText;
		open
]

{ #category : #querying }
PhLAboutCommand >> launcherCurrentMetacalloVersion [
	^ self launcherMetacalloConfiguration currentVersion
]

{ #category : #querying }
PhLAboutCommand >> launcherMTProject [
	^ project ifNil: [ project := MCModel2MTModelVisitor new 
		visitConfiguration: self launcherMetacalloConfiguration 
		withVersion: self launcherCurrentMetacalloVersion ]
]

{ #category : #querying }
PhLAboutCommand >> launcherMetacalloConfiguration [
	^ MBConfigurationRoot current configurationInfoFor: ConfigurationOfPharoLauncher
]

{ #category : #querying }
PhLAboutCommand >> launcherVersion [

	^ LauncherVersion ifNil: [ 'N/A' ] 
]
