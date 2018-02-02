settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #developmentEnvironmentEnabled) 
		parent: #pharoLauncher;
		target: self;
		label: 'Enable development environment' translated;
		description: 'Missing a feature?  Hey come join in!  Add your custom feature.
When enabled, exits the Launcher application into the Pharo development environment.
When disabled, closes all windows and locks Launcher as the only running application. ' translated.