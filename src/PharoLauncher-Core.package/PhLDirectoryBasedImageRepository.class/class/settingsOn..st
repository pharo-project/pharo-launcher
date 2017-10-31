settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #locationString)
		label: 'Location of your images' translated;
		type: #Directory;
		parent: #pharoLauncher;
		target: self;
		order: 40;
		description: 'A directory where all your Pharo images will be saved and launched'