Extension { #name : #PharoCommandLineHandler }

{ #category : #'*PharoLauncher-Core' }
PharoCommandLineHandler >> runPreferences [
	"When Pharo Launcher is deployed, ignore Pharo preferences. Pharo preferences will only be loaded when Pharo Launcher is in developer mode."
	"PhLSettingBrowser startup action is in charge of loading launcher preferences."
	PharoLauncherModel isDeployed ifTrue: [ ^ self ].
	
	Smalltalk at: #SystemSettingsPersistence ifPresent: [:persistence | 
		persistence resumeSystemSettings ].
	Smalltalk at: #StartupPreferencesLoader ifPresent: [:loader |
		loader default loadFromDefaultLocations ].
]
