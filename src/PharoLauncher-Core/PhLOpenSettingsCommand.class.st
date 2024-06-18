"
Command to open the Settings browser.
"
Class {
	#name : 'PhLOpenSettingsCommand',
	#superclass : 'PhLGeneralCommand',
	#classVars : [
		'LauncherVersion'
	],
	#category : 'PharoLauncher-Core-Commands',
	#package : 'PharoLauncher-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
PhLOpenSettingsCommand >> asSpecCommand [
	
	^ super asSpecCommand
		iconName: #configuration;
		yourself
]

{ #category : 'executing' }
PhLOpenSettingsCommand >> execute [

	^ (PhLSettingBrowser forKeywords: #( #pharoLauncherSettings ))
			loadSettings;
			open
]

{ #category : 'initialization' }
PhLOpenSettingsCommand >> initialize [
	super initialize.
	self
		name: 'Open settings';
		description: 'Open Pharo Launcher settings'
]
