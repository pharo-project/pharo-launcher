Class {
	#name : 'StoredSettingsFactoryTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'tests' }
StoredSettingsFactoryTest >> testStoreBooleanSetting [
	| setting storedSetting stonString deserializedStoredSetting |
	setting := SettingsTestData booleanSetting.
	
	storedSetting := StoredSettingsFactory new from: setting.
	
	self assert: storedSetting isNotNil.
	stonString := STON toStringPretty: storedSetting.
	self assert: stonString isNotNil.
	deserializedStoredSetting := STON fromString: stonString.
	self assert: deserializedStoredSetting isNotNil.
	self assert: deserializedStoredSetting equals: storedSetting
]
