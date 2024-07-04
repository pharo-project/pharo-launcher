Class {
	#name : 'PhLAppearanceSettingsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'lightThemePresenter',
		'darkThemePresenter'
	],
	#category : 'PharoLauncher-Spec2',
	#package : 'PharoLauncher-Spec2'
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
