Class {
	#name : #PhLSettingsTest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-Core'
}

{ #category : #utility }
PhLSettingsTest >> beDeployedDuring: aBlock [

	PhLDeploymentScript isDeployed ifTrue: [ ^ self ].
	
	PhLDeploymentScript makeDeployed.
	[ aBlock value ]
	ensure: [ PhLDeploymentScript makeUndeployed ]
]

{ #category : #tests }
PhLSettingsTest >> testDevelopmentEnvironmentEnabledSettingIsNotStored [

	| settingsFile settingNodes persistence |
	
	settingsFile := (FileSystem memory root / 'settings.txt') ensureCreateFile.
	
	settingNodes := (PhLSettingBrowser forKeywords: #( #pharoLauncherSettings )) 
					treeHolder nodeList.
	persistence := SystemSettingsPersistence new
		fileReference: settingsFile;
		yourself.  
	
	self beDeployedDuring: [ persistence storeSettingNodes: settingNodes ].
	
	self deny: (settingsFile contents includesSubstring: #developmentEnvironmentEnabled)
]
