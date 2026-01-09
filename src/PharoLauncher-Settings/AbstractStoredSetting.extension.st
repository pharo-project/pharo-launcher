Extension { #name : 'AbstractStoredSetting' }

{ #category : '*PharoLauncher-Settings' }
AbstractStoredSetting >> isForSettingIdentifier: aSettingIdentifier [

	^ self settingNodeIdentifier = aSettingIdentifier
]
