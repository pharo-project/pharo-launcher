"
I allow to choose the Pharo Launcher theme.
"
Class {
	#name : 'PhLAppearanceSettingsPresenter',
	#superclass : 'PhLAbstractSettingsPresenter',
	#instVars : [
		'lightThemePresenter',
		'darkThemePresenter',
		'fontSizePresenter'
	],
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'instance creation' }
PhLAppearanceSettingsPresenter class >> open [

	<script>

	^ self new open
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> activeTheme [

	^ self settings uiThemeClass 
		ifNotNil: [ :aThemeClass | aThemeClass uniqueInstance ]
		ifNil: [ self defaultActiveTheme ]
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
		yourself
]

{ #category : 'initialization' }
PhLAppearanceSettingsPresenter >> initializePresenters [ 

	lightThemePresenter := self newThemePresenter: PhLAppearanceTheme light.
	darkThemePresenter := self newThemePresenter:  PhLAppearanceTheme dark.
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
 		GRunLoop enterSystem: [
			self selectTheme: aTheme.
			presenter addStyle: 'welcomeThemeSelected' 
		] 
	].

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
			aTheme activateOn: self application.
			self settings uiThemeClass: aTheme class.
			aPresenter addStyle: 'welcomeThemeSelected' ]
]

{ #category : 'private' }
PhLAppearanceSettingsPresenter >> settingIdentifierFor: aSettingName [
	
	^ #appearance, aSettingName printString
]
