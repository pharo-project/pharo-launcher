"
I allow to choose the Pharo Launcher theme.
"
Class {
	#name : 'PhLAppearanceSettingsPresenter',
	#superclass : 'PhLAbstractSettingsPresenter',
	#instVars : [
		'lightThemePresenter',
		'darkThemePresenter',
		'compactModeSwitch'
	],
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'instance creation' }
PhLAppearanceSettingsPresenter class >> open [

	<script>

	^ (self on: PharoLauncherSettings new) open
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> activeTheme [

	^ self settings uiThemeClass 
		ifNotNil: [ :aThemeClass | aThemeClass uniqueInstance ]
		ifNil: [ self defaultActiveTheme ]
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> compactModeChanged: aBoolean [

	self settings compactMode: aBoolean.
	PharoLauncherApplication compactMode: aBoolean.
	self application imagesPresenter ifNotNil: [ :presenter | presenter applyCompactMode ]
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> defaultActiveTheme [

	^ self application isLightTheme
		ifTrue: [ PhLAppearanceTheme light ]
		ifFalse: [ PhLAppearanceTheme dark ]
]

{ #category : 'layout' }
PhLAppearanceSettingsPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  vAlignStart;
		  add: (SpBoxLayout newLeftToRight
				   add: lightThemePresenter;
				   add: darkThemePresenter;
				   yourself);
		  add: (SpBoxLayout newLeftToRight
				   spacing: 8;
				   add: 'Compact mode' expand: false;
				   add: compactModeSwitch expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> inUIThreadDo: aBlock [
	"Gtk needs UI changes made from an event handler to run in its run loop"

	self application isMorphicBackend
		ifTrue: [ aBlock value ]
		ifFalse: [ GRunLoop enterSystem: aBlock ]
]

{ #category : 'initialization' }
PhLAppearanceSettingsPresenter >> initializePresenters [

	lightThemePresenter := self newThemePresenter: PhLAppearanceTheme light.
	darkThemePresenter := self newThemePresenter: PhLAppearanceTheme dark.
	compactModeSwitch := self newSwitch
		                     state: PharoLauncherApplication compactMode;
		                     help: 'Smaller rows in the images list and a smaller image details panel';
		                     whenChangedDo: [ :state | self compactModeChanged: state ];
		                     yourself
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> newThemePresenter: aTheme [
	| presenter imagePresenter labelPresenter |
	
	presenter := self newPresenter.
	presenter propertyAt: #theme put: aTheme.
	presenter addStyle: 'welcomeThemeImage'.
	self activeTheme = aTheme ifTrue: [
		presenter addStyle: 'welcomeThemeSelected' ].
	
	imagePresenter := presenter newImage 
		autoScale: true;
		yourself.
	labelPresenter := presenter newLabel.
	
	presenter layout: (SpBoxLayout newTopToBottom
		hAlignCenter;
		add: imagePresenter;
		add: labelPresenter expand: false;
		yourself).
		
	labelPresenter label: aTheme name.
	"labelPresenter addStyle: 'subtitle'."

	imagePresenter image: aTheme image.
	imagePresenter addStyle: 'image'.
		
	presenter eventHandler whenMouseDownDo: [ :anEvent | 
		self inUIThreadDo: [
			self selectTheme: aTheme.
			presenter addStyle: 'welcomeThemeSelected' ] ].

	^ presenter
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> selectTheme: aTheme [
	| themePresenters |

	themePresenters := { lightThemePresenter. darkThemePresenter }.
	themePresenters do: [ :each | each removeStyle: 'welcomeThemeSelected' ].
	themePresenters 
		detect: [ :each | (each propertyAt: #theme ifAbsent: [ nil ]) = aTheme ]
		ifFound: [ :aPresenter |
			"Store the theme first: the application reads it when activating the theme"
			self settings uiThemeClass: aTheme class.
			aTheme activateOn: self application.
			aPresenter addStyle: 'welcomeThemeSelected' ]
]
