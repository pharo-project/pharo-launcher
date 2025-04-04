Class {
	#name : 'PhLAppearanceThemeLight',
	#superclass : 'PhLAppearanceTheme',
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'private' }
PhLAppearanceThemeLight >> activateOn: anApplication [

	anApplication switchThemeToLight
]

{ #category : 'accessing' }
PhLAppearanceThemeLight >> image [

	^ StWelcomeTheme light image
]

{ #category : 'accessing' }
PhLAppearanceThemeLight >> name [

	^ 'Light'
]
