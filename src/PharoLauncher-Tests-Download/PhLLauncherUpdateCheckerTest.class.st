"
I specify how the launcher finds out that a newer Pharo Launcher is published.
The server is replaced by PhLDownloadManagerMock.
"
Class {
	#name : 'PhLLauncherUpdateCheckerTest',
	#superclass : 'TestCase',
	#instVars : [
		'checker',
		'shouldRun',
		'launcherVersion'
	],
	#category : 'PharoLauncher-Tests-Download',
	#package : 'PharoLauncher-Tests-Download'
}

{ #category : 'helpers' }
PhLLauncherUpdateCheckerTest >> runningVersion: aString [

	PhLAboutCommand version: aString
]

{ #category : 'helpers' }
PhLLauncherUpdateCheckerTest >> server [

	^ PhLDownloadManager default
]

{ #category : 'helpers' }
PhLLauncherUpdateCheckerTest >> serverPublishes: aVersionString [

	self server
		atUrl: checker downloadUrl
		redirectTo: 'https://files.pharo.org/pharo-launcher/' , aVersionString , '/PharoLauncher-' , aVersionString , '.dmg'
]

{ #category : 'running' }
PhLLauncherUpdateCheckerTest >> setUp [

	super setUp.
	PhLDownloadManagerMock install.
	shouldRun := PhLLauncherUpdateChecker shouldRun.
	launcherVersion := PhLAboutCommand version.
	PhLLauncherUpdateChecker shouldRun: true.
	PhLLauncherUpdateChecker reset.
	checker := PhLLauncherUpdateChecker new
]

{ #category : 'running' }
PhLLauncherUpdateCheckerTest >> tearDown [

	checker announcer unsubscribe: self.
	PhLLauncherUpdateChecker reset.
	PhLLauncherUpdateChecker shouldRun: shouldRun.
	PhLAboutCommand version: launcherVersion.
	PhLDownloadManagerMock remove.
	super tearDown
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testAnnouncesWhenCheckIsDone [

	| isDone |
	isDone := false.
	checker announcer when: PhLLauncherUpdateCheckDone do: [ isDone := true ] for: self.

	checker check.

	self assert: isDone
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testDevelopmentLauncherDoesNotAskTheServer [

	self runningVersion: 'N/A'.
	self serverPublishes: '3.4.5'.

	checker check.

	self deny: checker isUpdateAvailable.
	self assert: self server redirectionRequestCount equals: 0
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testDisabledCheckDoesNotAskTheServer [

	self runningVersion: '3.4.4'.
	self serverPublishes: '3.4.5'.
	PhLLauncherUpdateChecker shouldRun: false.

	checker check.

	self deny: checker isUpdateAvailable.
	self assert: self server redirectionRequestCount equals: 0
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testDisablingTheCheckHidesTheUpdateFound [

	self runningVersion: '3.4.4'.
	self serverPublishes: '3.4.5'.
	checker check.

	PhLLauncherUpdateChecker shouldRun: false.

	self deny: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testDownloadUrlIsTheOfficialOneOfTheCurrentPlatform [

	self assert: (checker downloadUrl beginsWith: 'https://files.pharo.org/pharo-launcher/').
	self assert: (#( 'mac-arm64' 'mac-x64' 'windows' 'linux64' ) includes: (checker downloadUrl substrings: '/') last)
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testDownloadUrlOnMacDependsOnTheProcessor [
	"files.pharo.org/pharo-launcher/mac always answers the Apple silicon package"

	self assert: (checker macPlatformNameFor: 'arm64') equals: 'mac-arm64'.
	self assert: (checker macPlatformNameFor: 'x86_64') equals: 'mac-x64'
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testLatestVersionIsKeptWhenServerDoesNotAnswer [

	self runningVersion: '3.4.4'.
	self serverPublishes: '3.4.5'.
	checker check.
	self server redirections removeAll.

	checker check.

	self assert: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testLatestVersionIsTheOnePublished [

	self runningVersion: '3.4.4'.
	self serverPublishes: '3.4.5'.

	checker check.

	self assert: checker latestVersion printString equals: '3.4.5'
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testNoUpdateBeforeAnyCheck [

	self runningVersion: '3.4.4'.

	self deny: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testNoUpdateWhenOlderVersionIsPublished [

	self runningVersion: '4.0-alpha-2'.
	self serverPublishes: '3.4.5'.

	checker check.

	self deny: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testNoUpdateWhenServerDoesNotRedirect [

	self runningVersion: '3.4.4'.
	self server atUrl: checker downloadUrl redirectTo: nil.

	checker check.

	self deny: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testNoUpdateWhenServerRedirectsElsewhere [

	self runningVersion: '3.4.4'.
	self server atUrl: checker downloadUrl redirectTo: 'https://pharo.org/download'.

	checker check.

	self deny: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testNoUpdateWhenSameVersionIsPublished [

	self runningVersion: '3.4.5'.
	self serverPublishes: '3.4.5'.

	checker check.

	self deny: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testUpdateAvailableWhenNewerVersionIsPublished [

	self runningVersion: '3.4.4'.
	self serverPublishes: '3.4.5'.

	checker check.

	self assert: checker isUpdateAvailable
]

{ #category : 'tests' }
PhLLauncherUpdateCheckerTest >> testUpdateAvailableForCommitsAfterAnOlderTag [

	self runningVersion: '3.4.4-12-gabcdef0'.
	self serverPublishes: '3.4.5'.

	checker check.

	self assert: checker isUpdateAvailable
]
