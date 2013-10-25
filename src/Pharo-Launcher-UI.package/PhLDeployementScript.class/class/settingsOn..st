settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #isDeployed) 
		parent: #pharoLauncher;
		target: self;
		label: 'Enable development environment' translated;
		description: 'Missing a feature? Add it yourself.' translated.