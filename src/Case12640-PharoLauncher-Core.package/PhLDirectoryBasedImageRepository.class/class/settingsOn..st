settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #locationString)
		label: 'Location of your images' translated;
		parent: #pharoLauncher;
		target: self;
		description: 'A directory where all your Pharo images will be saved and launched'