system startup
launcherStartUp
	PhLDeploymentScript isDeployed
		ifFalse: [ ^ self ].
	self preferencesFile ifNotNil: [ self new treeHolder updateSettingNodes ]