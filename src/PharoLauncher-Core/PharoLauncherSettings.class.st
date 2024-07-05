"
I manage Pharo Launcher settings.
I reuse settings pragma already defined and provide a nice API to set settings.
I'm used by the Pharo Launcher settings presenter.
"
Class {
	#name : 'PharoLauncherSettings',
	#superclass : 'Object',
	#instVars : [
		'settingNodes'
	],
	#category : 'PharoLauncher-Core-Settings',
	#package : 'PharoLauncher-Core',
	#tag : 'Settings'
}

{ #category : 'private' }
PharoLauncherSettings >> buildSettingNodes [	
	^ StSettingsTree new
		acceptableKeywords: { #pharoLauncherSettings };
		newSettingTreeBuilderNodes
]

{ #category : 'accessing' }
PharoLauncherSettings >> checkTemplateSourcesUpdate: aBoolean [ 
	
	self setValueOfDeclarationNamed: #shouldCheckTemplateSourcesUpdate with: aBoolean
]

{ #category : 'accessing' }
PharoLauncherSettings >> clearTemplatesAtStartup: aBoolean [

	self setValueOfDeclarationNamed: #templatesClearedOnStartup with: aBoolean
]

{ #category : 'private' }
PharoLauncherSettings >> declarationNamed: aSettingIdentifier [

	^ (self settingNodeNamed: aSettingIdentifier) declaration
]

{ #category : 'accessing' }
PharoLauncherSettings >> enableDevelopmentEnvironment: aBoolean [ 

	self setValueOfDeclarationNamed: #developmentEnvironmentEnabled with: aBoolean
]

{ #category : 'resetting' }
PharoLauncherSettings >> hardResetPersistanceState [

	PharoLauncherApplication hardResetPersistanceState: true
]

{ #category : 'accessing' }
PharoLauncherSettings >> imagesLocation: aString [ 
	
	self setValueOfDeclarationNamed: #locationString with: aString
]

{ #category : 'accessing' }
PharoLauncherSettings >> initializationScriptsLocation: aFileReference [ 
	
	self setValueOfDeclarationNamed: #initializationScriptsLocation with: aFileReference
]

{ #category : 'accessing' }
PharoLauncherSettings >> launchInALoginShell: aBoolean [

	self setValueOfDeclarationNamed: #launchInALoginShell with: aBoolean
]

{ #category : 'accessing' }
PharoLauncherSettings >> quitOnLaunch: aBoolean [ 
	
	self setValueOfDeclarationNamed: #quitOnLaunch with: aBoolean
]

{ #category : 'private' }
PharoLauncherSettings >> setValueOfDeclarationNamed: aName with: anArgument [
	| declaration |
	
	declaration := self declarationNamed: aName.
	declaration settingReceiver perform: declaration setSelector with: anArgument.

]

{ #category : 'private' }
PharoLauncherSettings >> settingNodeNamed: aSettingIdentifier [

	^ self settingNodes detect: [ :node | node declaration name = aSettingIdentifier ]
]

{ #category : 'private' }
PharoLauncherSettings >> settingNodes [	
	^ settingNodes ifNil: [ settingNodes := self buildSettingNodes ]
]

{ #category : 'accessing' }
PharoLauncherSettings >> sourcesFileLocation: aString [ 
	
	self setValueOfDeclarationNamed: #launcherCoreDirString with: aString
]

{ #category : 'accessing' }
PharoLauncherSettings >> sourcesUrl: aString [ 
	
	self setValueOfDeclarationNamed: #sourcesUrl with: aString
]

{ #category : 'ston persistence' }
PharoLauncherSettings >> stonOn: stonWriter [

	^ (StoredSettingsFactory new fromSettingNodes: self settingNodes) asArray
		stonOn: stonWriter
]

{ #category : 'private' }
PharoLauncherSettings >> valueOfDeclarationNamed: aName [
	| declaration |
	
	declaration := self declarationNamed: aName.
	^ declaration settingReceiver perform: declaration getSelector

]

{ #category : 'accessing' }
PharoLauncherSettings >> vmsLocation: aFileReference [ 
	
	self setValueOfDeclarationNamed: #vmStoreString with: aFileReference
]

{ #category : 'accessing' }
PharoLauncherSettings >> warnOnArchMismatch: aBoolean [ 

	self setValueOfDeclarationNamed: #warnOnArchMismatch with: aBoolean
]
