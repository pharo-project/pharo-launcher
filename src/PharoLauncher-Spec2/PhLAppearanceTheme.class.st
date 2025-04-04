Class {
	#name : 'PhLAppearanceTheme',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'PharoLauncher-Spec2-View-Settings',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View-Settings'
}

{ #category : 'accessing' }
PhLAppearanceTheme class >> all [

	^ { self light. self dark }
]

{ #category : 'accessing' }
PhLAppearanceTheme class >> dark [

	^ PhLAppearanceThemeDark uniqueInstance
]

{ #category : 'accessing' }
PhLAppearanceTheme class >> light [

	^ PhLAppearanceThemeLight uniqueInstance
]

{ #category : 'instance creation' }
PhLAppearanceTheme class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : 'instance creation' }
PhLAppearanceTheme class >> uniqueInstance [

	self = PhLAppearanceTheme ifTrue: [
		self error: 'I''m an abstract class, use one of my children instead.' ].
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : 'private' }
PhLAppearanceTheme >> activateOn: anApplication [

	self subclassResponsibility
]

{ #category : 'accessing' }
PhLAppearanceTheme >> image [

	^ self subclassResponsibility
]

{ #category : 'testing' }
PhLAppearanceTheme >> isDark [

	^ self isLight not
]

{ #category : 'testing' }
PhLAppearanceTheme >> isLight [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
PhLAppearanceTheme >> name [

	^ self subclassResponsibility
]
