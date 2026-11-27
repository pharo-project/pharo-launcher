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
		description: 'All settings concerned with the look''n feel of your system';
		target: PolymorphSystemSettings;
		with: [
				(aBuilder pickOne: #uiThemeClass)
					label: 'User interface theme';
					target: self;
					order: 1;
					domainValues: PhLAppearanceTheme all.
				(aBuilder setting: #compactMode)
					label: 'Compact mode' translated;
					target: PharoLauncherApplication;
					order: 2;
					description: 'When enabled, the images list uses smaller rows and the image details panel takes less space. Good for people keeping a lot of images in their launcher.' ]
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass [

	^ UIThemeClass
]

{ #category : 'morphic' }
PhLAppearanceSettings class >> uiThemeClass: aUIThemeClass [

	UIThemeClass := aUIThemeClass
]
