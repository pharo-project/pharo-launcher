"
I check if there is an update for Launcher template sources.
I am regularly asked to check by the `PhLUpdateChecker` process.

Command line uses a different template sources check. See `PhLCliTemplateSourcesChecker` class
"
Class {
	#name : 'PhLTemplateSourcesUpdateChecker',
	#superclass : 'Object',
	#classVars : [
		'ShouldRun'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'settings' }
PhLTemplateSourcesUpdateChecker class >> settingsOn: aBuilder [

	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #shouldCheckTemplateSourcesUpdate)
		label: 'Check for template sources update?';
		groupName: #pharoLauncher;
		target: self;
		getSelector: #shouldRun;
		setSelector: #shouldRun:;
		order: 55;
		description:
			'Check if Pharo Launcher Template sources has an update available (needs internet access)'
]

{ #category : 'settings' }
PhLTemplateSourcesUpdateChecker class >> shouldRun [
	^ ShouldRun ifNil: [ ShouldRun := true ]
]

{ #category : 'settings' }
PhLTemplateSourcesUpdateChecker class >> shouldRun: aBoolean [
	ShouldRun := aBoolean
]

{ #category : 'accessing' }
PhLTemplateSourcesUpdateChecker >> check [

	self class shouldRun ifFalse: [ ^ self ].
	[ PhLPharoTemplateSources fromFile checkForUpdates ]
	on: PhLDownloadError 
	do: [ :e | "ignore. No internet connection available" ]
]
