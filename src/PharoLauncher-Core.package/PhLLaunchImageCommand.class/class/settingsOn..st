settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #quitOnLaunch)
				label: 'Quit On Launch' translated;
				parent: #pharoLauncher;
				target: self;
				description: 'When enabled, Launcher quits when an image is launched. ' , String cr , 
					'When disabled, Launcher stays alive when an image is launched.' translated.
					
	(aBuilder setting: #vmFullPath)
				label: 'VM Full Path' translated;
				parent: #pharoLauncher;
				target: self;
				description: 'When set, this is the full path (including executable name) to the VM used to launch an image. ' , String cr , 
					'When empty, Launcher uses it''s internal VM.', String cr,
					'NOTE: This path might need to escape some whitespace characters e.g. "/Pharo\ 3.0/Pharo".' translated.