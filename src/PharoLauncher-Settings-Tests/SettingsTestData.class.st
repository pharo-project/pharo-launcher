Class {
	#name : 'SettingsTestData',
	#superclass : 'Object',
	#instVars : [
		'scaleFactor',
		'shouldQuit'
	],
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'settings' }
SettingsTestData class >> basicSettingOn: aBuilder [
	<basic_setting_test_data>

	aBuilder setting: #basicSetting

]

{ #category : 'accessing - settings' }
SettingsTestData class >> basicSettingWithGroupAndNoTarget [

	^ (self settingsFor: #basic_setting_with_group_and_no_target_test_data)
		  detect: [ :each | each name = #basicSettingWithGroupAndNoTarget ]
]

{ #category : 'settings' }
SettingsTestData class >> basicSettingWithGroupAndNoTargetOn: aBuilder [
	<basic_setting_with_group_and_no_target_test_data>

	(aBuilder group: #basicGroupNoTarget)
		with: [ aBuilder setting: #basicSettingWithGroupAndNoTarget ]
]

{ #category : 'accessing - settings' }
SettingsTestData class >> basicSettingWithGroupTarget [

	^ (self settingsFor: #basic_setting_with_group_target_test_data)
		  detect: [ :each | each name = #basicSettingWithGroupTarget ]
]

{ #category : 'settings' }
SettingsTestData class >> basicSettingWithGroupTargetOn: aBuilder [
	<basic_setting_with_group_target_test_data>

	(aBuilder group: #basicGroup)
		target: Object;
		with: [ aBuilder setting: #basicSettingWithGroupTarget ]
]

{ #category : 'accessing - settings' }
SettingsTestData class >> basicSettingWithGroupTargetSelector [

	^ (self settingsFor: #basic_setting_with_group_target_selector_test_data)
		  detect: [ :each | each name = #basicSettingWithGroupTargetSelector ]
]

{ #category : 'settings' }
SettingsTestData class >> basicSettingWithGroupTargetSelectorOn: aBuilder [
	<basic_setting_with_group_target_selector_test_data>

	(aBuilder group: #basicGroup)
		target: Array;
		targetSelector: #empty;
		with: [ aBuilder setting: #basicSettingWithGroupTargetSelector ]
]

{ #category : 'settings' }
SettingsTestData class >> basicSettingWithTargetOn: aBuilder [
	<basic_setting_with_target_test_data>

	(aBuilder setting: #basicSettingWithTarget)
		target: String

]

{ #category : 'settings' }
SettingsTestData class >> basicSettingWithTargetSelectorOn: aBuilder [
	<basic_setting_with_target_selector_test_data>

	(aBuilder setting: #basicSettingWithTargetSelector)
		target: String;
		targetSelector: #empty

]

{ #category : 'settings' }
SettingsTestData class >> basicSettingsGroupOn: aBuilder [
	<basic_settings_group_test_data>

	(aBuilder group: #nonInteractive)
		label: 'Headless mode';
		"parent: #pharoSystem;"
		description: 'Settings related to mode without UI'
]

{ #category : 'accessing - settings' }
SettingsTestData class >> booleanSetting [

	^ (self settingsFor: #boolean_setting_test_data) first
]

{ #category : 'settings' }
SettingsTestData class >> booleanSettingWithDefaultOn: aBuilder [

	<boolean_setting_test_data>
	(aBuilder setting: #booleanSettingWithDefault)
		name: 'shouldQuit';
		description: 'will quit the app after action if setting set to true';
		target: self new;
		label: 'A boolean setting';
		defaultValue: false
]

{ #category : 'settings' }
SettingsTestData class >> pickOneSettingOn: aBuilder [

	<pick_one_setting_test_data>
	(aBuilder pickOne: #uiThemeClass)
		label: 'User interface theme';
		target: self;
		defaultValue: PhLAppearanceThemeLight;
		order: 1;
		domainValues: PhLAppearanceTheme all
]

{ #category : 'accessing - settings' }
SettingsTestData class >> rangeSetting [

	^ (self settingsFor: #range_setting_test_data) first
]

{ #category : 'settings' }
SettingsTestData class >> rangeSettingOn: aBuilder [

	<range_setting_test_data>
	(aBuilder range: #scaleFactor)
		groupName: #appearance;
		order: 3;
		defaultValue: 1;
		label: 'Display scale factor';
		description:
			'Specify scale factor for UI elements. This setting does not affect defined font sizes.';
		target: self new;
		range: (0.5 to: 5 by: 0.5)
]

{ #category : 'accessing - settings' }
SettingsTestData class >> settings [
	
	^ self settingsFor: #settings_test_data
]

{ #category : 'accessing - settings' }
SettingsTestData class >> settingsFor: aPragmaName [

	^ (SettingsBuilder forPragmaNamed: aPragmaName) settings
]

{ #category : 'settings' }
SettingsTestData class >> settingsGroupWithSettingOn: aBuilder [

	<settings_group_with_setting_test_data>
	(aBuilder group: #nonInteractive)
		label: 'Headless mode';
		groupName: #pharoSystem;
		description: 'Settings related to mode without UI';
		with: [
				(aBuilder setting: #snapshotErrorImage)
					label: 'Snapshot before quitting';
					defaultValue: false;
					target: self;
					description:
						'On unhandled exception, save a new version of the image before quitting' ]
]

{ #category : 'settings accessors' }
SettingsTestData >> scaleFactor [

	^ scaleFactor
]

{ #category : 'settings accessors' }
SettingsTestData >> scaleFactor: aNumber [

	scaleFactor := aNumber 
]

{ #category : 'settings accessors' }
SettingsTestData >> shouldQuit [

	^ shouldQuit
]

{ #category : 'settings accessors' }
SettingsTestData >> shouldQuit: aBoolean [

	shouldQuit := aBoolean
]
