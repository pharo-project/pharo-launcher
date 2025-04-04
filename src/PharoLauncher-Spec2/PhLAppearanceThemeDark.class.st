Class {
	#name : 'PhLAppearanceThemeDark',
	#superclass : 'PhLAppearanceTheme',
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'private' }
PhLAppearanceThemeDark >> activateOn: anApplication [

	anApplication switchThemeToDark
]

{ #category : 'accessing' }
PhLAppearanceThemeDark >> image [

	^ StWelcomeTheme dark image
]

{ #category : 'testing' }
PhLAppearanceThemeDark >> isLight [

	^ false
]

{ #category : 'accessing' }
PhLAppearanceThemeDark >> name [

	^ 'Dark'
]
