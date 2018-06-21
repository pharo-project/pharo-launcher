settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #quitOnLaunch)
		label: 'Quit On Launch' translated;
		parent: #pharoLauncher;
		target: self;
		order: 30;
		description:
			'When enabled, Launcher quits when an image is launched. ' , String cr
				, 'When disabled, Launcher stays alive when an image is launched.'.
	(aBuilder setting: #warnOnArchMismatch)
		label: self archMismatchSettingLabel;
		parent: #pharoLauncher;
		target: self;
		order: 35;
		description: self archMismatchSettingDescription