"
Command to open the Settings browser.
"
Class {
	#name : #PhLOpenSettingsCommand2,
	#superclass : #PhLGeneralCommand2,
	#classVars : [
		'LauncherVersion'
	],
	#category : #'PharoLauncher-Core-Commands2'
}

{ #category : #converting }
PhLOpenSettingsCommand2 >> asSpecCommand [
	^ super asSpecCommand
		iconName: #configurationIcon;
		yourself
]

{ #category : #executing }
PhLOpenSettingsCommand2 >> execute [
	^ (PhLSettingBrowser forKeywords: #( #pharoLauncherSettings )) open
]

{ #category : #initialization }
PhLOpenSettingsCommand2 >> initialize [
	super initialize.
	self
		basicName: 'Open settings';
		basicDescription: 'Open Pharo Launcher settings'
]
