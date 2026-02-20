"
Process used to chek regularly if there is an update for Launcher template sources.

```
PhLTemplateSourcesUpdateChecker runFor: application.
PhLTemplateSourcesUpdateChecker terminate 
```

Command line uses a different template sources check. See `PhLCliTemplateSourcesChecker` class
"
Class {
	#name : 'PhLTemplateSourcesUpdateChecker',
	#superclass : 'Object',
	#instVars : [
		'process',
		'application'
	],
	#classVars : [
		'ShouldRun',
		'UniqueInstance'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'running' }
PhLTemplateSourcesUpdateChecker class >> runFor: aPharoLauncherApplication [

	self shouldRun ifFalse: [ ^ self terminate ].
	
	self uniqueInstance runFor: aPharoLauncherApplication
	
	
]

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
	ShouldRun := aBoolean.
	('ShouldRun?', ShouldRun asString) traceCr.
	"ShouldRun 
		ifTrue: [ self run ]
		ifFalse: [ self terminate ]."
]

{ #category : 'running' }
PhLTemplateSourcesUpdateChecker class >> terminate [
	self uniqueInstance terminate
	
	
]

{ #category : 'running' }
PhLTemplateSourcesUpdateChecker class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : 'accessing' }
PhLTemplateSourcesUpdateChecker >> check [
	[ PhLPharoTemplateSources fromFile checkForUpdates: application ]
	on: PhLDownloadError 
	do: [ :e | "ignore. No internet connection available" ]
]

{ #category : 'accessing' }
PhLTemplateSourcesUpdateChecker >> name [
	^ 'Launcher sources update checker'
]

{ #category : 'accessing' }
PhLTemplateSourcesUpdateChecker >> priority [
	^ 20
]

{ #category : 'actions' }
PhLTemplateSourcesUpdateChecker >> runFor: aPharoLauncherApplication [

	application := aPharoLauncherApplication.
	self terminate.
	process := [ [ self check.
					self wait ] repeat ]
				forkAt: self priority named: self name
]

{ #category : 'actions' }
PhLTemplateSourcesUpdateChecker >> terminate [

	process ifNotNil: [
		process isTerminating ifFalse: [ process terminate ] ]
]

{ #category : 'actions' }
PhLTemplateSourcesUpdateChecker >> wait [
	24 hours wait.
]
