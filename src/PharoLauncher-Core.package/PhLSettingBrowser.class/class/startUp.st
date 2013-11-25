system startup
startUp
	| preferenceFiles |
	preferenceFiles := StartupPreferencesHandler new
		lookInFolder: PhLSettingBrowser preferencesFolder
		forFilesMatching: '*.st'.
	StartupLoader default load: preferenceFiles 