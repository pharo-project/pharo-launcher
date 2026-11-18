"
I test the lifecycle of PharoLauncherApplication, especially its subscriptions to the shared announcers and its progress runner.
"
Class {
	#name : 'PharoLauncherApplicationTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'progressRunner'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'tests' }
PharoLauncherApplicationTest >> catchAllDropHandlerCount [

	^ ExternalDropHandler registeredHandlers count: [ :handler | handler isKindOf: PhLCatchAllDropHandler ]
]

{ #category : 'running' }
PharoLauncherApplicationTest >> setUp [

	super setUp.
	progressRunner := ITProgressRunner default.
	application := PharoLauncherApplication new.
	application
		initializeProgressRunner;
		initializeTemplateSourcesAnnouncer
]

{ #category : 'running' }
PharoLauncherApplicationTest >> tearDown [

	application unsubscribeFromAnnouncers.
	ITProgressRunner default: progressRunner.
	super tearDown
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testApplicationIsSubscribedToAnnouncers [

	self assert: (PhLTemplateSourcesAnnouncer default hasSubscriber: application)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testApplicationIsSubscribedToVmUpdateChecker [

	application initializeVmUpdateChecker.

	self assert: (application vmUpdateChecker announcer hasSubscriber: application)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testApplicationShowsProgress [

	self assert: ITProgressRunner default application identicalTo: application
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFileIsNotAnImageFolder [

	| launcher file |
	launcher := PharoLauncherApplication new.
	file := FileSystem memory / 'foo.image'.
	file ensureCreateFile.
	self deny: (launcher isImageFolder: file)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFolderContainingAnImageIsAnImageFolder [

	| launcher folder |
	launcher := PharoLauncherApplication new.
	folder := FileSystem memory / 'dropped'.
	folder createDirectory.
	(folder / 'foo.image') ensureCreateFile.
	self assert: (launcher isImageFolder: folder)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFolderWithDottedNameIsHandledByTheLauncher [

	| launcher folder |
	launcher := PharoLauncherApplication new.
	launcher registerExternalDropHandler.
	[
		folder := FileSystem memory / 'Pharo 13.0 - 64bit (stable)'.
		folder createDirectory.
		(folder / 'foo.image') ensureCreateFile.
		self assert: (ExternalDropHandler lookupExternalDropHandler: folder) identicalTo: launcher externalDropHandler ] ensure: [ launcher unregisterExternalDropHandler ]
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFolderWithUpperCaseImageIsAnImageFolder [

	| launcher folder |
	launcher := PharoLauncherApplication new.
	folder := FileSystem memory / 'upper-case-folder'.
	folder createDirectory.
	(folder / 'Foo.IMAGE') ensureCreateFile.
	self assert: (launcher isImageFolder: folder)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFolderWithoutImageIsNotAnImageFolder [

	| launcher folder |
	launcher := PharoLauncherApplication new.
	folder := FileSystem memory / 'not-an-image-folder'.
	folder createDirectory.
	(folder / 'readme.txt') ensureCreateFile.
	self deny: (launcher isImageFolder: folder)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testRegisteringTwiceKeepsOneDropHandler [

	| launcher countBefore |
	launcher := PharoLauncherApplication new.
	countBefore := self catchAllDropHandlerCount.
	[
		launcher registerExternalDropHandler.
		launcher registerExternalDropHandler.
		self assert: self catchAllDropHandlerCount equals: countBefore + 1 ] ensure: [ launcher unregisterExternalDropHandler ]
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testReleasingSharedResourcesUnregistersDropHandler [

	| launcher countBefore |
	launcher := PharoLauncherApplication new.
	countBefore := self catchAllDropHandlerCount.
	launcher registerExternalDropHandler.
	launcher releaseSharedResources.
	self assert: self catchAllDropHandlerCount equals: countBefore
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testResetReleasesProgressRunner [

	PharoLauncherApplication
		useDefault: application
		during: [ PharoLauncherApplication reset ].

	self deny: ITProgressRunner default application identicalTo: application
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testResetUnsubscribesDefaultApplicationFromTemplateSourcesAnnouncer [

	PharoLauncherApplication
		useDefault: application
		during: [ PharoLauncherApplication reset ].

	self deny: (PhLTemplateSourcesAnnouncer default hasSubscriber: application)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testResetWhenDefaultIsNotificationCenter [
	"Headless, the default application is a notification center (see PhLDeploymentScript class>>#launcherStartUp)"

	PharoLauncherApplication
		useDefault: PhLNotificationCenter new
		during: [
			self
				shouldnt: [ PharoLauncherApplication reset ]
				raise: MessageNotUnderstood ]
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testSubscribingTwiceDoesNotDuplicateSubscriptions [

	| subscriptions |
	application initializeTemplateSourcesAnnouncer.

	subscriptions := PhLTemplateSourcesAnnouncer default subscriptions subscriptions
		select: [ :each | each subscriber == application ].
	"One subscription per announcement: PhLTemplateSourcesUpdateAvailable and PhLTemplateSourcesUpdated"
	self assert: subscriptions size equals: 2
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testUnsubscribeFromAnnouncers [

	application unsubscribeFromAnnouncers.

	self deny: (PhLTemplateSourcesAnnouncer default hasSubscriber: application)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testUnsubscribeFromVmUpdateAnnouncements [

	application initializeVmUpdateChecker.

	application unsubscribeFromAnnouncers.

	self deny: (PhLVmUpdateAnnouncer default hasSubscriber: application)
]
