"
I manage Pharo Launcher settings.
I reuse settings pragma already defined and provide a nice API to set settings.
I'm used by the Pharo Launcher settings presenter.
"
Class {
	#name : 'PharoLauncherSettings',
	#superclass : 'Object',
	#instVars : [
		'manager'
	],
	#category : 'PharoLauncher-Core-Settings',
	#package : 'PharoLauncher-Core',
	#tag : 'Settings'
}

{ #category : 'accessing' }
PharoLauncherSettings >> checkTemplateSourcesUpdate: aBoolean [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#shouldCheckTemplateSourcesUpdate' with: aBoolean
]

{ #category : 'accessing' }
PharoLauncherSettings >> clearTemplatesAtStartup: aBoolean [

	self setValueOfSettingNamed: '#pharoLauncher#templatesClearedOnStartup' with: aBoolean
]

{ #category : 'resetting' }
PharoLauncherSettings >> hardResetPersistanceState [

	PharoLauncherApplication hardResetPersistanceState: true
]

{ #category : 'accessing' }
PharoLauncherSettings >> imagesLocation: aString [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#locationString' with: aString
]

{ #category : 'accessing' }
PharoLauncherSettings >> initializationScriptsLocation: aFileReference [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#initializationScriptsLocation' with: aFileReference
]

{ #category : 'initialization' }
PharoLauncherSettings >> initialize [ 

	super initialize.
	manager := SettingsManager forPragmaNamed: #pharoLauncherSettings
]

{ #category : 'accessing' }
PharoLauncherSettings >> launchInALoginShell: aBoolean [

	self setValueOfSettingNamed: '#pharoLauncher#launchInALoginShell' with: aBoolean
]

{ #category : 'accessing - network' }
PharoLauncherSettings >> proxyPassword: aString [ 
	
	self setValueOfSettingNamed: '#network#useNetworkAuthentification#proxyPassword' with: aString
]

{ #category : 'accessing - network' }
PharoLauncherSettings >> proxyPort: aString [ 
	
	self setValueOfSettingNamed: '#network#useHTTPProxy#httpProxyPort' with: aString
]

{ #category : 'accessing - network' }
PharoLauncherSettings >> proxyServer: aString [ 
	
	self setValueOfSettingNamed: '#network#useHTTPProxy#httpProxyServer' with: aString
]

{ #category : 'accessing - network' }
PharoLauncherSettings >> proxyUser: aString [ 
	
	self setValueOfSettingNamed: '#network#useNetworkAuthentification#proxyUser' with: aString
]

{ #category : 'accessing' }
PharoLauncherSettings >> quitOnLaunch: aBoolean [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#quitOnLaunch' with: aBoolean
]

{ #category : 'private' }
PharoLauncherSettings >> setValueOfSettingNamed: aSettingName with: aValue [
	
	| setting |
	setting := self settingNamed: aSettingName.
	setting realValue = aValue ifTrue: [ ^ self ].
	
	setting realValue: aValue.
	self store

]

{ #category : 'private' }
PharoLauncherSettings >> settingNamed: aSettingName [

	^ manager settingNamed: aSettingName
]

{ #category : 'accessing' }
PharoLauncherSettings >> sourcesFileLocation: aString [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#launcherCoreDirString' with: aString
]

{ #category : 'accessing' }
PharoLauncherSettings >> sourcesUrl: aString [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#sourcesUrl' with: aString
]

{ #category : 'persistence' }
PharoLauncherSettings >> store [

	manager storeSettings
]

{ #category : 'accessing - appearance' }
PharoLauncherSettings >> uiThemeClass [

	^ self valueOfSettingNamed: #uiThemeClass
]

{ #category : 'accessing - appearance' }
PharoLauncherSettings >> uiThemeClass: aClass [

	self setValueOfSettingNamed: #uiThemeClass with: aClass
]

{ #category : 'private' }
PharoLauncherSettings >> valueOfSettingNamed: aSettingName [
	
	^ (self settingNamed: aSettingName) realValue
]

{ #category : 'accessing' }
PharoLauncherSettings >> vmsLocation: aFileReference [ 
	
	self setValueOfSettingNamed: '#pharoLauncher#vmStoreString' with: aFileReference
]

{ #category : 'accessing' }
PharoLauncherSettings >> warnOnArchMismatch: aBoolean [ 

	self setValueOfSettingNamed: '#pharoLauncher#warnOnArchMismatch' with: aBoolean
]
