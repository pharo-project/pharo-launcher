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
						order: 20;
						target: PharoLauncher;
						description:
								'When enabled, Launcher startup clears the Templates List. ' , String cr
										, 'When disabled, Launcher startup retains the Templates List from last run.' translated.
		
					(aBuilder setting: #hardResetPersistanceState)
						label: 'Hard reset persistant state' translated;
						target: PharoLauncher;
						order: 70;
						description:
								'When PharoLauncher is updated through Monticello ' , 
								'sometimes you need to clear persistant state to pick up new changes.' , String cr, 
								'Clicking this box is a one-shot action, i.e. this state is also reset.', String cr, 
								'Note, all open windows are clsoed and the application restarted.'
								translated 
		
		]