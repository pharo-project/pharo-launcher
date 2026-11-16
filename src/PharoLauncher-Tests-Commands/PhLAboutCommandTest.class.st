Class {
	#name : 'PhLAboutCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter',
		'application'
	],
	#category : 'PharoLauncher-Tests-Commands',
	#package : 'PharoLauncher-Tests-Commands'
}

{ #category : 'accessing' }
PhLAboutCommandTest >> application [

	^ application ifNil: [ application := PhLTestApplication new ]
]

{ #category : 'running' }
PhLAboutCommandTest >> tearDown [
	presenter window 
		ifNotNil: [ :window | window close].
	super tearDown
]

{ #category : 'tests' }
PhLAboutCommandTest >> testCanOpenAboutDialog [
	| command |
	command := PhLAboutCommand forContext: self.
	
	presenter := command execute.

	self assert: (presenter description text includesSubstring: 'Pharo Launcher')
]

{ #category : 'accessing' }
PhLAboutCommandTest >> window [
	"In a non-testing environment this message will be send to a SpWindowPresenter"
	^ nil
]

{ #category : 'tests' }
PhLAboutCommandTest >> testDownloadLinkWhenLauncherUpdateIsAvailable [

	self application launcherUpdateChecker: (PhLTestLauncherUpdateChecker latestVersion: '3.4.5').

	presenter := (PhLAboutCommand forContext: self) execute.

	self assert: presenter updateNotice isVisible.
	self assert: presenter updateNotice label equals: 'Pharo Launcher 3.4.5 is available'.
	self assert: presenter updateLink isVisible.
	self assert: presenter updateLink label equals: 'Download Pharo Launcher 3.4.5 (web)'
]

{ #category : 'tests' }
PhLAboutCommandTest >> testUpdateNoticeIsAHeader [

	self application launcherUpdateChecker: (PhLTestLauncherUpdateChecker latestVersion: '3.4.5').

	presenter := (PhLAboutCommand forContext: self) execute.

	self assert: (presenter updateNotice styles includes: 'form_header')
]

{ #category : 'tests' }
PhLAboutCommandTest >> testUpdateNoticeHasAnIcon [

	self application launcherUpdateChecker: (PhLTestLauncherUpdateChecker latestVersion: '3.4.5').

	presenter := (PhLAboutCommand forContext: self) execute.

	self assert: presenter updateIcon isVisible.
	self assert: presenter updateIcon image equals: (presenter iconNamed: #smallUpdate)
]

{ #category : 'tests' }
PhLAboutCommandTest >> testNoDownloadLinkWithoutLauncherUpdate [

	self application launcherUpdateChecker: (PhLTestLauncherUpdateChecker latestVersion: nil).

	presenter := (PhLAboutCommand forContext: self) execute.

	self deny: presenter updateIcon isVisible.
	self deny: presenter updateNotice isVisible.
	self deny: presenter updateLink isVisible
]
