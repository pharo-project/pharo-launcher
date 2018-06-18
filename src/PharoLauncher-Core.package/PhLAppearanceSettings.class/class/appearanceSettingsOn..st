settings
appearanceSettingsOn: aBuilder 
	<pharoLauncherSettings>
	(aBuilder group: #appearance)
		label: 'Appearance' ;  
		description: 'All settings concerned with the look''n feel of your system';
		target: PolymorphSystemSettings;
		with: [
			(aBuilder pickOne: #uiThemeClass)
				label: 'User interface theme';
				target: PolymorphSystemSettings;
				default: UITheme standardThemeClass;
				order: 1;
				domainValues: PolymorphSystemSettings uiThemeClassChoices. ]