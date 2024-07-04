Class {
	#name : 'PharoLauncherSettingsTest',
	#superclass : 'TestCase',
	#instVars : [
		'settings',
		'templatesClearedOnStartup',
		'checkTemplateSourcesUpdate',
		'quitOnLaunch',
		'launchInALoginShell',
		'warnOnArchMismatch',
		'sourcesUrl',
		'imagesLocation',
		'sourcesFileLocation',
		'initializationScriptsLocation',
		'vmLocation'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'running' }
PharoLauncherSettingsTest >> setUp [
	super setUp.
	settings := PharoLauncherSettings new.
	templatesClearedOnStartup := PharoLauncherApplication templatesClearedOnStartup.
	checkTemplateSourcesUpdate := PhLTemplateSourcesUpdateChecker shouldRun.
	quitOnLaunch := PhLLaunchImageCommand quitOnLaunch.
	launchInALoginShell := PhLLaunchConfiguration launchInALoginShell.
	warnOnArchMismatch := PhLLaunchImageCommand warnOnArchMismatch.
	sourcesUrl := PhLPharoTemplateSources sourcesUrl.
	imagesLocation := PhLDirectoryBasedImageRepository locationString.
	sourcesFileLocation := PhLTemplateSources launcherCoreDirString.
	initializationScriptsLocation := PharoLauncherApplication initializationScriptsLocation.
	vmLocation := PhLVirtualMachineManager vmStoreString.
]

{ #category : 'running' }
PharoLauncherSettingsTest >> tearDown [

	PharoLauncherApplication templatesClearedOnStartup: templatesClearedOnStartup.
	PhLTemplateSourcesUpdateChecker shouldRun: checkTemplateSourcesUpdate.
	PhLLaunchImageCommand quitOnLaunch: quitOnLaunch.
	PhLLaunchConfiguration launchInALoginShell: launchInALoginShell.
	PhLLaunchImageCommand warnOnArchMismatch: warnOnArchMismatch.
	PhLPharoTemplateSources sourcesUrl: sourcesUrl.
	PhLDirectoryBasedImageRepository locationString: imagesLocation.
	PhLTemplateSources launcherCoreDirString: sourcesFileLocation.
	PharoLauncherApplication initializationScriptsLocation: initializationScriptsLocation.
	PhLVirtualMachineManager vmStoreString: vmLocation.
	super tearDown
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetCheckTemplateSourcesUpdate [

	settings checkTemplateSourcesUpdate: false.
	self deny: PhLTemplateSourcesUpdateChecker shouldRun.
	
	settings checkTemplateSourcesUpdate: true.
	self assert: PhLTemplateSourcesUpdateChecker shouldRun
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetImagesLocation [

	self skip: 'Need to handle application that is nil'.
	
	settings imagesLocation: '/tmp/foo'.
	self deny: PhLDirectoryBasedImageRepository locationString
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetInitializationScriptsLocation [

	settings initializationScriptsLocation: '/tmp/foo' asFileReference.
	self assert: PharoLauncherApplication initializationScriptsLocation equals: '/tmp/foo'
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetLaunchInALoginShell [

	settings launchInALoginShell: false.
	self deny: PhLLaunchConfiguration launchInALoginShell.
	
	settings launchInALoginShell: true.
	self assert: PhLLaunchConfiguration launchInALoginShell
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetQuitOnLaunch [

	settings quitOnLaunch: false.
	self deny: PhLLaunchImageCommand quitOnLaunch.
	
	settings quitOnLaunch: true.
	self assert: PhLLaunchImageCommand quitOnLaunch
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetSourcesFileLocation [

	settings sourcesFileLocation: '/tmp/foo'.
	self assert: PhLTemplateSources launcherCoreDirString equals: '/tmp/foo'
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetTemplatesClearedAtStartup [

	settings clearTemplatesAtStartup: false.
	self deny: PharoLauncherApplication templatesClearedOnStartup.
	
	settings clearTemplatesAtStartup: true.
	self assert: PharoLauncherApplication templatesClearedOnStartup
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetVmsLocation [

	settings vmsLocation: '/tmp/foo' asFileReference.
	self assert: PhLVirtualMachineManager vmStoreString equals: '/tmp/foo'
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanSetWarnOnImageArchitectureMismatch [

	settings warnOnArchMismatch: false.
	self deny: PhLLaunchImageCommand warnOnArchMismatch.
	
	settings warnOnArchMismatch: true.
	self assert: PhLLaunchImageCommand warnOnArchMismatch
]

{ #category : 'tests' }
PharoLauncherSettingsTest >> testCanStoreSettings [

	| stonString |
	stonString := STON toStringPretty: settings.
	
	self assert: (stonString withInternetLineEndings beginsWith: 
		'[
	StoredSetting {
		#settingNodeIdentifier : ''#pharoLauncher#launchInALoginShell'',
		#realValue : true
	},' withInternetLineEndings).
]
