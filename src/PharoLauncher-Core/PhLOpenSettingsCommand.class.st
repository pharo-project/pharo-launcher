"
Command to open the Settings interface.
"
Class {
	#name : #PhLOpenSettingsCommand,
	#superclass : #PhLGeneralCommand,
	#category : 'PharoLauncher-Core-Commands'
}

{ #category : #accessing }
PhLOpenSettingsCommand class >> icon [
	^ self iconNamed: #configurationIcon
]

{ #category : #accessing }
PhLOpenSettingsCommand class >> title [
	^ 'Open settings'
]

{ #category : #action }
PhLOpenSettingsCommand >> execute [
	PhLSettingBrowser browse: #( #pharoLauncherSettings )
]
