"
I test the lifecycle of PharoLauncherApplication, especially its subscriptions to the shared announcers and its progress runner.
"
Class {
	#name : 'PharoLauncherApplicationTest',
	#superclass : 'TestCase',
	#instVars : [
		'application',
		'progressRunner',
		'worldApplication'
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
	worldApplication ifNotNil: [
		worldApplication unsubscribeFromAnnouncers.
		PhLLauncherUpdateAnnouncer default unsubscribe: worldApplication ].
	ITProgressRunner default: progressRunner.
	super tearDown
]

{ #category : 'running' }
PharoLauncherApplicationTest >> startWorldApplication [
	"The Morphic application is opened as the world (see PhLDeploymentScript class>>#openLauncher)"

	worldApplication := PhLTestApplication new
		beOpenedAsWorld;
		yourself.
	"The test application creates its image repository lazily"
	worldApplication imageRepository.
	worldApplication start
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> temporaryFolderNamed: aName containing: aFileName [

	| folder |
	folder := FileLocator temp / aName.
	folder ensureDeleteAll.
	folder ensureCreateDirectory.
	(folder / aFileName) ensureCreateFile.
	^ folder
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
PharoLauncherApplicationTest >> testApplicationOpenedAsWorldIsSubscribedToAnnouncers [

	self startWorldApplication.

	self
		assert: (PhLTemplateSourcesAnnouncer default hasSubscriber: worldApplication);
		assert: (worldApplication vmUpdateChecker announcer hasSubscriber: worldApplication);
		assert: (worldApplication launcherUpdateChecker announcer hasSubscriber: worldApplication)
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testApplicationOpenedAsWorldShowsProgress [

	self startWorldApplication.

	self assert: ITProgressRunner default application identicalTo: worldApplication
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testApplicationShowsProgress [

	self assert: ITProgressRunner default application identicalTo: application
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testDefaultContextWhenDefaultIsNotificationCenter [
	"Headless, the default application is a notification center (see PhLDeploymentScript class>>#launcherStartUp)"

	| result |
	PharoLauncherApplication
		useDefault: PhLNotificationCenter new
		during: [
			PhLCurrentContext value application
				pushProgress: 'test'
				with: [ :bar |
					bar label: 'test'; current: 25.
					result := 42 ] ].

	self assert: result equals: 42
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testDisplayProgressWhenDefaultIsNotificationCenter [
	"Headless, the default application is a notification center (see PhLDeploymentScript class>>#launcherStartUp)"

	| result |
	PharoLauncherApplication
		useDefault: PhLNotificationCenter new
		during: [
			ITProgressRunner
				use: ITProgressRunner new
				during: [ result := PhLProgressManager displayProgress: 'test' during: [ :job | 42 ] ] ].

	self assert: result equals: 42
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFolderWithUpperCaseImageOffersImportService [

	| folder labels |
	folder := self temporaryFolderNamed: 'upper-case-folder' containing: 'Foo.IMAGE'.
	[
		labels := (FileServices itemsForFile: folder fullName) collect: [ :service | service label ].
		self assert: (labels includes: 'Import image') ] ensure: [ folder ensureDeleteAll ]
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testFolderWithoutImageOffersNoImportService [

	| folder labels |
	folder := self temporaryFolderNamed: 'not-an-image-folder' containing: 'readme.txt'.
	[
		labels := (FileServices itemsForFile: folder fullName) collect: [ :service | service label ].
		self deny: (labels includes: 'Import image') ] ensure: [ folder ensureDeleteAll ]
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testImageFileOffersLaunchServiceAndNoImportService [

	| folder labels |
	folder := self temporaryFolderNamed: 'image-file-folder' containing: 'foo.image'.
	[
		labels := (FileServices itemsForFile: (folder / 'foo.image') fullName) collect: [ :service | service label ].
		self assert: (labels includes: 'Launch image').
		self deny: (labels includes: 'Import image') ] ensure: [ folder ensureDeleteAll ]
]

{ #category : 'tests' }
PharoLauncherApplicationTest >> testImageFolderOffersImportService [

	| folder labels |
	folder := self temporaryFolderNamed: 'Pharo 13.0 - 64bit (stable)' containing: 'foo.image'.
	[
		labels := (FileServices itemsForFile: folder fullName) collect: [ :service | service label ].
		self assert: (labels includes: 'Import image') ] ensure: [ folder ensureDeleteAll ]
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
