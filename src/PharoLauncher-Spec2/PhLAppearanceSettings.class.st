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
					order: 1;
					domainValues: PhLAppearanceTheme all ]
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass [

	^ UIThemeClass
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass: aUIThemeClass [

	UIThemeClass := aUIThemeClass
]
