settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #vmStore)
		label: 'VMs Directory' translated;
		type: #Directory;
		parent: #pharoLauncher;
		target: self;
		default: (PlatformResolver forCurrentPlatform launcherUserFilesLocation / 'vms') pathString;
		description:
			'Path to the directory containing all the VMs to launcher your Pharo images.' , String cr
				, 'You must have the read/write rights on this folder.' , String cr
				, 'NOTE: This path might need to escape some whitespace characters e.g. "/Pharo\ 3.0/Pharo".' translated