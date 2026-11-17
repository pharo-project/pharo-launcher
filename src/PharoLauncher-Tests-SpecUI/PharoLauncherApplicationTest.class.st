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
