settings
standardFontsSettingsOn: aBuilder
	<pharoLauncherSettings>
	(aBuilder group: #standardFonts)
		label: 'Standard fonts';
		target: StandardFonts;
		dialog: [GraphicFontSettings fontSizeRow];
		parent: #appearance;
		order: 4.