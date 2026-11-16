"
I specify how the application warns the user that a newer Pharo Launcher is published: without interrupting, through the About button of the main window.
"
Class {
	#name : 'PharoLauncherApplicationLauncherUpdateTest',
	#superclass : 'TestCase',
	#instVars : [
		'imagesPresenter'
	],
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'helpers' }
PharoLauncherApplicationLauncherUpdateTest >> aboutIconExtent [

	^ PhLAboutCommand new asSpecCommand icon extent
]

{ #category : 'running' }
PharoLauncherApplicationLauncherUpdateTest >> setUp [

	super setUp.
	imagesPresenter := PhLTestImagesPresenter new
]

{ #category : 'tests' }
PharoLauncherApplicationLauncherUpdateTest >> testAboutButtonIsBadgedWhenUpdateIsAvailable [

	| icon badgeColor |
	imagesPresenter showLauncherUpdate: (PhLLauncherVersion fromString: '3.4.5').

	icon := imagesPresenter aboutButton icon.
	badgeColor := icon colorAt: (icon width - 6) @ 1.
	self assert: (badgeColor red > 0.8 and: [ badgeColor green < 0.3 ]).
	self assert: imagesPresenter aboutButton help equals: 'Pharo Launcher 3.4.5 is available'.
	self assert: imagesPresenter aboutButton label equals: 'About'
]

{ #category : 'tests' }
PharoLauncherApplicationLauncherUpdateTest >> testAboutButtonIsNotBadgedWithoutUpdate [

	imagesPresenter showLauncherUpdate: (PhLLauncherVersion fromString: '3.4.5').

	imagesPresenter showLauncherUpdate: nil.

	self assert: imagesPresenter aboutButton icon extent equals: self aboutIconExtent.
	self assert: imagesPresenter aboutButton help equals: PhLAboutCommand new description
]

{ #category : 'tests' }
PharoLauncherApplicationLauncherUpdateTest >> testMainWindowShowsLauncherUpdateOnceCheckIsDone [

	| application |
	application := imagesPresenter application.
	application launcherUpdateChecker: (PhLTestLauncherUpdateChecker latestVersion: '3.4.5').

	application launcherUpdateCheckDone.

	self deny: imagesPresenter aboutButton icon extent equals: self aboutIconExtent
]

{ #category : 'tests' }
PharoLauncherApplicationLauncherUpdateTest >> testMainWindowShowsLauncherUpdateWhenOpened [
	"The latest version may be known before the main window opens"

	| window |
	imagesPresenter application launcherUpdateChecker: (PhLTestLauncherUpdateChecker latestVersion: '3.4.5').

	window := imagesPresenter open.

	[ self deny: imagesPresenter aboutButton icon extent equals: self aboutIconExtent ] ensure: [ window close ]
]
