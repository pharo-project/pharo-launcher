"
I provide Appearance seetings
for the PhLSettingsBrowser (pragma pharoLauncherSettings).
"
Class {
	#name : 'PhLAppearanceSettings',
	#superclass : 'Object',
	#classVars : [
		'UIThemeClass'
	],
	#category : 'PharoLauncher-Spec2-Model',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Model'
}

{ #category : 'settings' }
PhLAppearanceSettings class >> appearanceSettingsOn: aBuilder [ 
	<pharoLauncherSettings>
	
	(aBuilder group: #appearance)
		label: 'Appearance' ;  
		description: 'All settings concerned with the look''n feel of your system';
		target: PolymorphSystemSettings;
		with: [
			(aBuilder pickOne: #uiThemeClass)
				label: 'User interface theme';
				target: self;
				default: PhLAppearanceThemeLight;
				order: 1;
				domainValues: PhLAppearanceTheme all ]
]

{ #category : 'settings' }
PhLAppearanceSettings class >> standardFontsSettingsOn: aBuilder [
	<pharoLauncherSettings>
	(aBuilder group: #standardFonts)
		label: 'Standard fonts';
		target: StandardFonts;
		dialog: [GraphicFontSettings fontSizeRow];
		parent: #appearance;
		order: 4.
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass [

	^ UIThemeClass
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass: aUIThemeClass [

	UIThemeClass := aUIThemeClass
]
