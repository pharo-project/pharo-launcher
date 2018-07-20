settings
settingsOn: aBuilder
	<systemsettings>
	<pharoLauncherSettings>
	
	(aBuilder pickOne: #dateDisplayStrategy)
		label: 'Date format' translated;
		target: self;
		parent: ##appearance;
		order: 32;
		domainValues: PhLAbstractDateDisplayStrategy allStrategiesWithNames;
		description: 'Customize the format of the dates in the PharoLauncher UI.'.
		
	(aBuilder setting: #displayColorsForDates)
		label: 'Display dates with colors' translated;
		parent: #appearance;
		target: self;
		order: 34;
		description: 'When this option is enable it will display the date in colors. The color depend on the senority of the date.'