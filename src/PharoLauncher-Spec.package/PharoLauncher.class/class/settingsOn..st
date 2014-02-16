settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder group: #pharoLauncher)
		label: 'Pharo Launcher' translated;
		description: 'General application settings' translated;
		with: [ 
					(aBuilder setting: #templatesClearedOnStartup)
						label: 'Templates cleared at startup' translated;
						target: PharoLauncher;
						description:
								'When enabled, Launcher startup clears the Templates List. ' , String cr
										, 'When disabled, Launcher startup retains the Templates List from last run.' translated ]