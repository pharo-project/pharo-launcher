system startup
startUp
	| preferenceFiles |
	preferenceFiles := StartupPreferencesHandler new
		lookInFolder: PhLSettingBrowser preferencesFolder
		forFilesMatching: '*.st'.
	preferenceFiles ifNotNil: [ StartupLoader default load: preferenceFiles ]