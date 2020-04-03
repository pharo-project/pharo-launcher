"
Command to open the Settings browser.
"
Class {
	#name : #PhLOpenSettingsCommand,
	#superclass : #PhLGeneralCommand,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands'
}

{ #category : #converting }
PhLOpenSettingsCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #configurationIcon;
		yourself
]

{ #category : #executing }
PhLOpenSettingsCommand >> execute [
	^ (PhLSettingBrowser forKeywords: #( #pharoLauncherSettings )) open
]

{ #category : #initialization }
PhLOpenSettingsCommand >> initialize [
	super initialize.
	self
		name: 'Open settings';
		description: 'Open Pharo Launcher settings'
]
