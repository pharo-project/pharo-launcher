"
I represent an action modeled as a setting.
It is a convenience to build a UI automatically but should maybe not be used.
"
Class {
	#name : 'PhLActionSetting',
	#superclass : 'PhLAbstractSetting',
	#instVars : [
		'actionLabel'
	],
	#category : 'PharoLauncher-Settings',
	#package : 'PharoLauncher-Settings'
}

{ #category : 'initialization' }
PhLActionSetting >> buttonLabel: aString [

	actionLabel := aString
]

{ #category : 'setting - polymorphism' }
PhLActionSetting >> hasDefaultValue [

	"Do not store this setting. It has no value"
	^ true
]

{ #category : 'setting - polymorphism' }
PhLActionSetting >> realValue [

	"An action has no value"
	^ nil
]
