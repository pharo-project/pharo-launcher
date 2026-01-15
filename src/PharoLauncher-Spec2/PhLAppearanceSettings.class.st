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
		label: 'Appearance';
		description:
			'All settings concerned with the look''n feel of your system';
		target: PolymorphSystemSettings;
		with: [
				(aBuilder pickOne: #uiThemeClass)
					label: 'User interface theme';
					target: self;
					defaultValue: PhLAppearanceThemeLight;
					order: 1;
					domainValues: PhLAppearanceTheme all ]
]

{ #category : 'setting' }
PhLAppearanceSettings class >> displayScaleFactorSettingsOn: aBuilder [

	<pharoLauncherSettings>
	(aBuilder range: #scaleFactor)
		groupName: #appearance;
		order: 3;
		defaultValue: 1;
		label: 'Display scale factor';
		description:
			'Specify scale factor for UI elements. This setting does not affect defined font sizes.';
		target: WorldMorph;
		range: (0.5 to: 5 by: 0.5)
]

{ #category : 'settings' }
PhLAppearanceSettings class >> standardFontsSettingsOn: aBuilder [

	<pharoLauncherSettings>
	(aBuilder group: #standardFonts)
		label: 'Standard fonts';
		target: StandardFonts;
		dialog: [ GraphicFontSettings fontSizeRow ];
		groupName: #appearance;
		order: 4
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass [

	^ UIThemeClass
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass: aUIThemeClass [

	UIThemeClass := aUIThemeClass
]

{ #category : 'settings' }
PhLAppearanceSettings class >> worldRendererSettingsOn: aBuilder [

	<pharoLauncherSettings>
	(aBuilder group: #canvasScaleFactorGroup)
		groupName: #appearance;
		label: 'World renderer canvas scaling';
		with: [
				(aBuilder pickOne: #canvasScaleFactor)
					label: 'Canvas scale factor';
					target: OSWorldRenderer;
					domainValues: (1 to: 5);
					defaultValue: 1.
				(aBuilder setting: #autoSetCanvasScaleFactor)
					label: 'Set canvas scale factor automatically';
					target: OSWorldRenderer;
					defaultValue: true ]
]
