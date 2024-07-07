"
I allow to choose the Pharo Launcher theme.
"
Class {
	#name : 'PhLAppearanceSettingsPresenter',
	#superclass : 'PhLAbstractSettingsPresenter',
	#instVars : [
		'lightThemePresenter',
		'darkThemePresenter'
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

{ #category : 'layout' }
PhLAppearanceSettingsPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   spacing: 10;
				   add: lightThemePresenter;
				   add: darkThemePresenter;
				   yourself)
		  expand: false;
		  vAlignCenter 
]

{ #category : 'layout' }
PhLAppearanceSettingsPresenter >> initializePresenters [ 
	| welcomePresenter |
	
	welcomePresenter := StWelcomeSetupPresenter new.
	lightThemePresenter := welcomePresenter newThemePresenter: StWelcomeTheme light.
	darkThemePresenter := welcomePresenter newThemePresenter: StWelcomeTheme dark.
]
