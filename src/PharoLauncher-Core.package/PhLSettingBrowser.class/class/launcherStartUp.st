system startup
launcherStartUp
	self preferencesFile 
		ifNotNil: [ self new treeHolder updateSettingNodes ]