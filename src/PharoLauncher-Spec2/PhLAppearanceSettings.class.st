"
I provide Appearance seetings
for the PhLSettingsBrowser (pragma pharoLauncherSettings).
"
Class {
	#name : #PhLAppearanceSettings,
	#superclass : #Object,
	#category : #'PharoLauncher-Spec2'
}

{ #category : #settings }
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
				default: PharoLightTheme;
				order: 1;
				domainValues: PolymorphSystemSettings uiThemeClassChoices. ]
]

{ #category : #settings }
PhLAppearanceSettings class >> standardFontsSettingsOn: aBuilder [
	<pharoLauncherSettings>
	(aBuilder group: #standardFonts)
		label: 'Standard fonts';
		target: StandardFonts;
		dialog: [GraphicFontSettings fontSizeRow];
		parent: #appearance;
		order: 4.
]

{ #category : #morphic }
PhLAppearanceSettings class >> uiThemeClass [
	^ PolymorphSystemSettings uiThemeClass
]

{ #category : #morphic }
PhLAppearanceSettings class >> uiThemeClass: aUIThemeClass [
	PolymorphSystemSettings uiThemeClass: aUIThemeClass.
	"force UI re-creation to adopt new theme. Spec is not yet ready to react to theme changes."
	PharoLauncherApplication 
		reset;
		openFull.
]
