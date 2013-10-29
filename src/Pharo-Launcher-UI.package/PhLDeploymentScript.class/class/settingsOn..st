settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #developmentEnvironmentEnabled) 
		parent: #pharoLauncher;
		target: self;
		label: 'Enable development environment' translated;
		description: 'Missing a feature? Hey come join in!
Add your custom feature then share back to...
	MCSmalltalkhubRepository
	owner: ''Pharo''
	project: ''PharoLauncher'' ' translated.