Class {
	#name : 'PhLGeneralSettingsPresenterTest',
	#superclass : 'PharoLauncherSettingsTest',
	#instVars : [
		'presenter'
	],
	#category : 'PharoLauncher-Tests-Core',
	#package : 'PharoLauncher-Tests-Core'
}

{ #category : 'running' }
PhLGeneralSettingsPresenterTest >> setUp [
	super setUp.
	presenter := PhLGeneralSettingsPresenter on: settings
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetCheckTemplateSourcesUpdate [

	presenter checkForTemplateSourcesUpdateSwitch: false.
	self deny: PhLTemplateSourcesUpdateChecker shouldRun.

	presenter checkForTemplateSourcesUpdateSwitch: true.
	self assert: PhLTemplateSourcesUpdateChecker shouldRun
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetImagesLocation [

	self skip: 'Need to handle application that is nil'.

	presenter imagesLocation: '/tmp/foo'.

	self
		assert: PhLDirectoryBasedImageRepository locationString
		equals: '/tmp/foo'
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetInitializationScriptsLocation [

	presenter imagesInitScriptsLocation: '/tmp/foo'.

	self
		assert: PharoLauncherApplication initializationScriptsLocation
		equals: '/tmp/foo'
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetLaunchInALoginShell [

	presenter launchInALoginShell: false.
	self deny: PhLDefaultLaunchConfiguration launchInALoginShell.
	
	presenter launchInALoginShell: true.
	self assert: PhLDefaultLaunchConfiguration launchInALoginShell
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetQuitOnLaunch [

	presenter quitOnLaunch: false.
	self deny: PhLLaunchImageCommand quitOnLaunch.
	
	presenter quitOnLaunch: true.
	self assert: PhLLaunchImageCommand quitOnLaunch
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetSourcesFileLocation [

	presenter sourcesFileLocation: '/tmp/foo'.

	self
		assert: PhLTemplateSources launcherCoreDirString
		equals: '/tmp/foo'
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetTemplatesClearedAtStartup [

	presenter clearTemplatesAtStartup: false.
	self deny: PharoLauncherApplication templatesClearedOnStartup.
	
	presenter clearTemplatesAtStartup: true.
	self assert: PharoLauncherApplication templatesClearedOnStartup
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetVmsLocation [

	presenter vmsLocation: '/tmp/foo'.

	self
		assert: PhLVirtualMachineManager vmStoreString
		equals: '/tmp/foo'
]

{ #category : 'tests' }
PhLGeneralSettingsPresenterTest >> testCanSetWarnOnImageArchitectureMismatch [

	presenter warnOnArchMismatch: false.
	self deny: PhLLaunchImageCommand warnOnArchMismatch.
	
	presenter warnOnArchMismatch: true.
	self assert: PhLLaunchImageCommand warnOnArchMismatch
]
