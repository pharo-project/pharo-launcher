system startup
launcherStartUp
	| preferenceFiles |
	preferenceFiles := StartupPreferencesHandler new
		lookInFolder: PhLSettingBrowser preferencesFolder
		forFilesMatching: '*.ston'.
	preferenceFiles ifNotNil: [
		(SystemSettingsPersistence new 
			fileReference: preferenceFiles;
			settingTree: SettingBrowser new treeHolder;
			yourself) load: preferenceFiles ]