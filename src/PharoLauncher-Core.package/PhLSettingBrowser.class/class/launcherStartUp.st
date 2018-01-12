system startup
launcherStartUp
	| preferenceFiles |
	preferenceFiles := StartupPreferencesHandler new
		lookInFolder: PhLSettingBrowser preferencesFolder
		forFilesMatching: '*.st'.
	preferenceFiles ifNotNil: [ StartupPreferencesLoader default load: preferenceFiles ]