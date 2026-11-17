"
I check if a newer version of Pharo Launcher is published.
The official download URL of each platform (e.g. https://files.pharo.org/pharo-launcher/mac) redirects to the package of the latest version (https://files.pharo.org/pharo-launcher/3.4.5/...): I ask the server this redirection, without downloading anything, and read the version in it.
The latest version is kept in memory: the check runs each time the launcher starts.
A development launcher has no tagged version: it never asks the server.
I announce `PhLLauncherUpdateCheckDone` on `PhLLauncherUpdateAnnouncer default` once a check is done.

```
checker := PhLLauncherUpdateChecker new.
checker check.
checker isUpdateAvailable
```
"
Class {
	#name : 'PhLLauncherUpdateChecker',
	#superclass : 'Object',
	#classVars : [
		'LatestVersion',
		'ShouldRun'
	],
	#category : 'PharoLauncher-Core-Model',
	#package : 'PharoLauncher-Core',
	#tag : 'Model'
}

{ #category : 'initialization' }
PhLLauncherUpdateChecker class >> reset [
	"Forget the latest version found"

	LatestVersion := nil
]

{ #category : 'settings' }
PhLLauncherUpdateChecker class >> settingsOn: aBuilder [

	<systemsettings>
	<pharoLauncherSettings>
	(aBuilder setting: #shouldCheckLauncherUpdate)
		label: 'Check for Pharo Launcher update?';
		groupName: #pharoLauncher;
		target: self;
		getSelector: #shouldRun;
		setSelector: #shouldRun:;
		order: 54;
		description: 'Check if a newer version of Pharo Launcher is published (needs internet access)'
]

{ #category : 'settings' }
PhLLauncherUpdateChecker class >> shouldRun [

	^ ShouldRun ifNil: [ ShouldRun := true ]
]

{ #category : 'settings' }
PhLLauncherUpdateChecker class >> shouldRun: aBoolean [

	ShouldRun := aBoolean
]

{ #category : 'accessing' }
PhLLauncherUpdateChecker >> announcer [

	^ PhLLauncherUpdateAnnouncer default
]

{ #category : 'actions' }
PhLLauncherUpdateChecker >> check [

	(self class shouldRun and: [ self runningVersion isComparable ]) ifTrue: [ self fetchLatestVersion ].
	self announcer announce: PhLLauncherUpdateCheckDone new
]

{ #category : 'accessing' }
PhLLauncherUpdateChecker >> downloadUrl [
	"The official URL to download the latest Pharo Launcher for the current platform"

	^ 'https://files.pharo.org/pharo-launcher/' , self platformName
]

{ #category : 'private' }
PhLLauncherUpdateChecker >> fetchLatestVersion [
	"When the server does not answer, or answers something unexpected, the version found by the previous check is kept"

	| location |
	location := [ PhLDownloadManager default redirectionOf: self downloadUrl ]
		            on: PhLDownloadError
		            do: [ ^ self ].
	(self versionIn: location) ifNotNil: [ :version | LatestVersion := version ]
]

{ #category : 'testing' }
PhLLauncherUpdateChecker >> isUpdateAvailable [
	"Answer whether the last check found a version newer than the running one. The server is not asked."

	self class shouldRun ifFalse: [ ^ false ].
	LatestVersion ifNil: [ ^ false ].
	^ self runningVersion isComparable and: [ self runningVersion < LatestVersion ]
]

{ #category : 'accessing' }
PhLLauncherUpdateChecker >> latestVersion [
	"The latest published version found by the last check, nil if unknown"

	^ LatestVersion
]

{ #category : 'private' }
PhLLauncherUpdateChecker >> macPlatformNameFor: aProcessorArchitecture [
	"The processor of the machine, not the one the launcher runs on: an Intel launcher may run on Apple silicon"

	^ aProcessorArchitecture = MacOSXPlatform armArchitecture
		  ifTrue: [ 'mac-arm64' ]
		  ifFalse: [ 'mac-x64' ]
]

{ #category : 'private' }
PhLLauncherUpdateChecker >> platformName [

	Smalltalk os isMacOSX ifTrue: [ ^ self macPlatformNameFor: Smalltalk os hostArchitecture ].
	Smalltalk os isWindows ifTrue: [ ^ 'windows' ].
	^ 'linux64'
]

{ #category : 'accessing' }
PhLLauncherUpdateChecker >> runningVersion [

	^ PhLLauncherVersion fromString: PhLAboutCommand launcherVersion
]

{ #category : 'private' }
PhLLauncherUpdateChecker >> versionIn: aLocation [
	"Answer the version in a location like 'https://files.pharo.org/pharo-launcher/3.4.5/PharoLauncher-3.4.5.dmg', nil if there is none"

	| segments index version |
	aLocation ifNil: [ ^ nil ].
	segments := aLocation asZnUrl pathSegments.
	index := segments indexOf: 'pharo-launcher'.
	(index between: 1 and: segments size - 1) ifFalse: [ ^ nil ].
	version := PhLLauncherVersion fromString: (segments at: index + 1).
	^ version isComparable
		  ifTrue: [ version ]
		  ifFalse: [ nil ]
]
