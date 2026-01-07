Class {
	#name : 'SettingsBuilderTest',
	#superclass : 'TestCase',
	#instVars : [
		'builder'
	],
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'tests' }
SettingsBuilderTest >> testCanBuildAPickOneSetting [

	| setting |
	builder := SettingsBuilder forPragmaNamed: #pick_one_setting_test_data.
	
	self assert: builder settings size equals: 1.
	setting := builder settings first.
	self assert: setting name equals: #uiThemeClass.
	self assert: setting label equals: 'User interface theme'.
	self assert: setting defaultValue equals: PhLAppearanceThemeLight.
	self assert: setting domainValues equals: PhLAppearanceTheme all
]

{ #category : 'tests' }
SettingsBuilderTest >> testCanBuildARangeSetting [

	| setting |
	builder := SettingsBuilder forPragmaNamed: #range_setting_test_data.
	
	self assert: builder settings size equals: 1.
	setting := builder settings first.
	self assert: setting name equals: #scaleFactor.
	self assert: setting label equals: 'Display scale factor'.
	self assert: setting defaultValue equals: 1.
	self assert: setting range equals: (0.5 to: 5 by: 0.5)

]

{ #category : 'tests' }
SettingsBuilderTest >> testCanBuildASetting [

	| setting |
	builder := SettingsBuilder forPragmaNamed: #boolean_setting_test_data.
	
	self assert: builder settings size equals: 1.
	setting := builder settings first.
	self assert: setting name equals: #shouldQuit.
	self assert: setting description equals: 'will quit the app after action if setting set to true'.
	self assert: setting label equals:'A boolean setting'.
	self assert: setting defaultValue equals: false

]

{ #category : 'tests' }
SettingsBuilderTest >> testCanBuildASettingGroup [

	| settingGroup |
	builder := SettingsBuilder forPragmaNamed: #basic_settings_group_test_data.
	
	self assert: builder settings size equals: 1.
	settingGroup := builder settings first.
	self assert: settingGroup name equals: #nonInteractive.
	self assert: settingGroup description equals: 'Settings related to mode without UI'.
	self assert: settingGroup label equals: 'Headless mode'.
	self assert: settingGroup groupName equals: nil
]

{ #category : 'tests' }
SettingsBuilderTest >> testCanBuildASettingGroupDefiningASetting [

	| setting settingGroup |
	builder := SettingsBuilder forPragmaNamed: #settings_group_with_setting_test_data.
	
	self assert: builder settings size equals: 2.
	settingGroup := builder settings first.
	self assert: settingGroup name equals: #nonInteractive.
	
	setting := builder settings second.
	self assert: setting name equals: #snapshotErrorImage.
	self assert: setting groupName equals: settingGroup name.
	self assert: setting group equals: settingGroup

]
