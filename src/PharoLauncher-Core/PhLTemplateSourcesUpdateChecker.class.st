"
Process used to chek regurlarly if there is an update for Launcher template sources.

PhLTemplateSourcesUpdateChecker run.
PhLTemplateSourcesUpdateChecker terminate 

"
Class {
	#name : #PhLTemplateSourcesUpdateChecker,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#classVars : [
		'ShouldRun',
		'UniqueInstance'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #initialization }
PhLTemplateSourcesUpdateChecker class >> initialize [
	super initialize.
	PhLStartupManager addToLauncherStartUpList: self
]

{ #category : #'launcher startup' }
PhLTemplateSourcesUpdateChecker class >> launcherStartUp [
	self run
]

{ #category : #'launcher startup' }
PhLTemplateSourcesUpdateChecker class >> launcherStartUpPriority [
	^ 500
]

{ #category : #running }
PhLTemplateSourcesUpdateChecker class >> run [
	self shouldRun ifFalse: [ ^ self ].
	
	self uniqueInstance run
	
	
]

{ #category : #settings }
PhLTemplateSourcesUpdateChecker class >> settingsOn: aBuilder [
	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #shouldRun)
		label: 'Check for template sources update?' translated;
		parent: #pharoLauncher;
		target: self;
		order: 55;
		description: 'Check if Pharo Launcher Template sources has an update available (needs internet access)' translated
]

{ #category : #settings }
PhLTemplateSourcesUpdateChecker class >> shouldRun [
	^ ShouldRun ifNil: [ ShouldRun := true ]
]

{ #category : #settings }
PhLTemplateSourcesUpdateChecker class >> shouldRun: aBoolean [
	ShouldRun := aBoolean.
	ShouldRun 
		ifTrue: [ self run ]
		ifFalse: [ self terminate ].
]

{ #category : #running }
PhLTemplateSourcesUpdateChecker class >> terminate [
	self uniqueInstance terminate
	
	
]

{ #category : #running }
PhLTemplateSourcesUpdateChecker class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #updating }
PhLTemplateSourcesUpdateChecker >> basicUpdateTemplateSources [
	PhLPharoTemplateSources fromFile updateSourcesFile.
	PharoLauncherApplication resetTemplateRepository.
	PharoLauncherApplication default resetTemplateRepository.
]

{ #category : #accessing }
PhLTemplateSourcesUpdateChecker >> check [
	[ PhLPharoTemplateSources fromFile checkForUpdates ]
	on: PhLDownloadError 
	do: [ :e | "ignore. No internet connection available" ]
]

{ #category : #accessing }
PhLTemplateSourcesUpdateChecker >> name [
	^ 'Launcher sources update checker'
]

{ #category : #accessing }
PhLTemplateSourcesUpdateChecker >> priority [
	^ 20
]

{ #category : #updating }
PhLTemplateSourcesUpdateChecker >> registerOnTemplateSourcesUpdate [
	PhLPharoTemplateSources announcer weak
		when: PhLSourcesFileUpdateAvailable
		send: #updateTemplateSources:
		to: self.
]

{ #category : #actions }
PhLTemplateSourcesUpdateChecker >> run [
	self terminate.
	self registerOnTemplateSourcesUpdate.
	process := [ [ self check.
		self wait ] repeat ]
	forkAt: self priority named: self name
]

{ #category : #actions }
PhLTemplateSourcesUpdateChecker >> terminate [
	self unregisterFromTemplateSourcesUpdate.
	process ifNotNil: [ process isTerminating ifFalse: [ process terminate ] ]
]

{ #category : #updating }
PhLTemplateSourcesUpdateChecker >> unregisterFromTemplateSourcesUpdate [
	PhLPharoTemplateSources announcer
		unsubscribe: self.
]

{ #category : #updating }
PhLTemplateSourcesUpdateChecker >> updateTemplateSources: announcement [
	| applyUpdate |
	applyUpdate := UIManager default
		confirm: 'Update available for Pharo Launcher templates sources!'
		trueChoice: 'Update'
		falseChoice: 'Remind me later'.
	applyUpdate ifNil: [ ^ self ].
	applyUpdate ifFalse: [ ^ self ].
	
	self basicUpdateTemplateSources
]

{ #category : #actions }
PhLTemplateSourcesUpdateChecker >> wait [
	24 hours wait.
]
