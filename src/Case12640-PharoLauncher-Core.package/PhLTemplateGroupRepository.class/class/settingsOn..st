settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder group: #templateGroupRepositories)
		label: 'Choose Template Repositories' ;
		description: 'Configure which Template Repositories to show' translated ;
		parent: #pharoLauncher;
		with: 
		[ 	self allGroups do: 
			[ 	:group | 
				(aBuilder setting: ('want' , group name capitalized) asLegalSelector)
						label: 'Display ' , group name , ' projects';
						target: self;
						description: 'When enabled, projects from ' , group name , ' will be presented'
			].
		].