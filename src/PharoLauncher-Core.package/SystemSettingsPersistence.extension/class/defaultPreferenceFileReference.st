*PharoLauncher-Core
defaultPreferenceFileReference
	^  PhLDeploymentScript isDeployed
		ifTrue: [ FileLocator preferences asFileReference / 'pharo-launcher' / 'settings.ston' ]
		ifFalse: [ StartupPreferencesLoader preferencesVersionFolder / 'system-settings.ston' ]