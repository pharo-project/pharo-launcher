settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #launchInAShell)
		label: 'Launch image from a shell' translated;
		parent: #pharoLauncher;
		target: self;
		order: 31;
		description:
			'When enabled, Pharo Launcher will start a Shell and launch the image from it. ' , String cr
				, 'It allows to inherit from the Shell environment variables.' translated