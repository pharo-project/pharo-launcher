settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #launchInALoginShell)
		label: 'Launch image from a login shell' translated;
		parent: #pharoLauncher;
		target: self;
		order: 31;
		description:
			'When enabled, Pharo Launcher will start a Shell and launch the image from it. ' , String cr
				, 'It allows to inherit from the Shell environment variables.' translated