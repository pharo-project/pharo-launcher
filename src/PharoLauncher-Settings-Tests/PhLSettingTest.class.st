Class {
	#name : 'PhLSettingTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'tests' }
PhLSettingTest >> testCanReadRealValue [
	
	self assert: SettingsTestData booleanSetting realValue equals: false.
	self assert: SettingsTestData rangeSetting realValue equals: 1.
]

{ #category : 'tests' }
PhLSettingTest >> testCanSetRealValueWhenBooleanSetting [
	| setting |
	setting := SettingsTestData booleanSetting.
	
	setting realValue: false.
	self deny: setting realValue.
	
	setting realValue: true.
	self assert: setting realValue 
]

{ #category : 'tests' }
PhLSettingTest >> testCanSetRealValueWhenRangeSetting [
	| setting |
	setting := SettingsTestData rangeSetting.
	
	setting realValue: 2.
	self  assert: setting realValue equals: 2.
	
	setting realValue: 1.5.
	self  assert: setting realValue equals: 1.5.

]

{ #category : 'tests' }
PhLSettingTest >> testChildIdentifier [

	self
		assert: SettingsTestData rangeSetting settingIdentifier
		equals: '#appearance#scaleFactor'
]

{ #category : 'tests - realTarget' }
PhLSettingTest >> testReceiverIsClassDefiningSettingWhenNoTargetSpecified [

	| setting |
	setting := (SettingsTestData settingsFor: #basic_setting_test_data) first.

	self assert: setting settingReceiver equals: SettingsTestData
]

{ #category : 'tests - realTarget' }
PhLSettingTest >> testReceiverIsClassDefiningSettingWhenNoTargetSpecifiedAndGroupSWithNoTarget [

	self
		assert: SettingsTestData basicSettingWithGroupAndNoTarget settingReceiver
		equals: SettingsTestData
]

{ #category : 'tests - realTarget' }
PhLSettingTest >> testReceiverIsEvaluationOfGroupTargetSelectorWhenNoTargetSpecifiedAndGroupTargetSelectorSpecified [

	self
		assert: SettingsTestData basicSettingWithGroupTargetSelector settingReceiver
		equals: Array empty
]

{ #category : 'tests - realTarget' }
PhLSettingTest >> testReceiverIsEvaluationOfTargetSelectorWhenTargetSelectorSpecified [

	| setting |
	setting := (SettingsTestData settingsFor: #basic_setting_with_target_selector_test_data) first.

	self assert: setting settingReceiver equals: String empty
]

{ #category : 'tests - realTarget' }
PhLSettingTest >> testReceiverIsGroupTargetWhenNoTargetSpecified [

	self
		assert: SettingsTestData basicSettingWithGroupTarget settingReceiver
		equals: Object
]

{ #category : 'tests - realTarget' }
PhLSettingTest >> testReceiverIsTargetWhenTargetSpecified [

	| setting |
	setting := (SettingsTestData settingsFor: #basic_setting_with_target_test_data) first.

	self assert: setting settingReceiver equals: String
]

{ #category : 'tests' }
PhLSettingTest >> testRootIdentifier [

	self
		assert: SettingsTestData booleanSetting settingIdentifier
		equals: '#shouldQuit'
]
