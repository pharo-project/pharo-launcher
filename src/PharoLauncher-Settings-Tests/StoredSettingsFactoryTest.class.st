Class {
	#name : 'StoredSettingsFactoryTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Settings-Tests',
	#package : 'PharoLauncher-Settings-Tests'
}

{ #category : 'tests' }
StoredSettingsFactoryTest >> testStoreBooleanSetting [
	| setting stored string stored2 |
	setting := SettingsTestData booleanSetting.
	
	stored := StoredSettingsFactory new from: setting.
	
	self assert: stored isNotNil.
	string := String streamContents: [ :aStream | | writer |
		writer := STON writer on: aStream; prettyPrint: true; yourself.
		writer writeObject: stored.
	].
	self assert: string isNotNil.
	stored2 := STON fromString: string.
	self assert: stored2 isNotNil.
	self assert: stored2 equals: stored
]
