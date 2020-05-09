"
I'm exactly the same as the standard settings browser except I save to a dedicated pharo launcher setting file.
"
Class {
	#name : #PhLSettingBrowser,
	#superclass : #SettingBrowser,
	#category : #'PharoLauncher-Core-Settings'
}

{ #category : #initialization }
PhLSettingBrowser class >> initialize [

	PhLStartupManager addToLauncherStartUpList: self
]

{ #category : #'system startup' }
PhLSettingBrowser class >> launcherStartUp [
	PharoLauncherApplication isDeployed ifFalse: [ ^ self ].

	self preferencesFile ifNotNil: [ self new treeHolder updateSettingNodes ].

	"Allow to have manual settings in the preferences foldor of Pharo Launcher."
	self preferencesFolder exists ifTrue: [ StartupPreferencesLoader default load: (self preferencesFolder filesMatching: '*.st') ]
]

{ #category : #'system startup' }
PhLSettingBrowser class >> launcherStartUpPriority [
	^ 100
]

{ #category : #accessing }
PhLSettingBrowser class >> preferencesFile [
	^ (self preferencesFolder / 'settings.ston') asFileReference
]

{ #category : #private }
PhLSettingBrowser class >> preferencesFolder [
	^ FileLocator preferences / 'pharo-launcher'
]

{ #category : #private }
PhLSettingBrowser >> exportSettings: aCollection toFileNamed: filename [
	aCollection do: [ :startupAction | startupAction runOnce: false ].
	StartupPreferencesLoader default addAtStartup: aCollection inDirectory: self class preferencesFolder named: filename
]

{ #category : #'instance creation' }
PhLSettingBrowser >> newTreeHolder [
	^ PhLSettingTree new 
		acceptableKeywords: self settingsKeywords
		
]
