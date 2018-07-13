system startup
launcherStartUp
	PharoLauncherModel isDeployed
		ifFalse: [ ^ self ].
	self preferencesFile ifNotNil: [ self new treeHolder updateSettingNodes ]