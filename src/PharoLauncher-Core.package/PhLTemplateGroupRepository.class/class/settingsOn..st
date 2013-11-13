settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	self allGroups
		do: [ :group | 
			(aBuilder setting: ('want' , group name capitalized) asLegalSelector)
				label: 'Display ' , group name , ' projects';
				parent: #pharoLauncher;
				target: self;
				description: 'When enabled, projects from ' , group name , ' will be presented' ]