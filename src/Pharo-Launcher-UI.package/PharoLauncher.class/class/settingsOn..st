settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder group: #pharoLauncher) 
		label: 'Pharo Launcher' translated;
		description: 'General application settings' translated;
		with: 
		[	(aBuilder setting: #quitOnLaunch)
				label: 'Quit On Launch' translated;
				target: PharoLauncher;
				description: 'When enabled, the Launcher application quits after the next image is launched. ' , String cr , 'When disabled, the Launcher application remains alive after an image is Launced.' translated.
		]