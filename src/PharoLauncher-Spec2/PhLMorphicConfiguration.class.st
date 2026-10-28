"
I define the configuration for Pharo Launcher application on the Morphic backend.
I define styles making the Morphic UI look close to the Gtk (Adwaita) one.
"
Class {
	#name : 'PhLMorphicConfiguration',
	#superclass : 'SpMorphicConfiguration',
	#instVars : [
		'activeTheme'
	],
	#category : 'PharoLauncher-Spec2-Application',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Application'
}

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> launcherStyle [
	"Mirror the classes used by the Gtk launcherStyle, with colors from Adwaita light theme"

	^ '.application [
	.launcher [ Draw { #backgroundColor: #FAFAFA } ],
	.label [
		.list_header [ Font { #name: EnvironmentFont(#default), #bold: true } ],
		.status_message [ Draw { #color: #9A9A9A } ] ],
	.table [
		Container { #rowHeight: 28, #borderWidth: 0 },
		Draw { #selectionColor: #CFE0F5 } ],
	.textInputField [
		Container { #borderWidth: 0 },
		Draw { #color: #EBEBED } ],
	.text [
		Container { #borderWidth: 0 },
		Draw { #backgroundColor: #EBEBED } ],
	.dropList [ Container { #borderWidth: 0 } ],
	.actionButton [
		.flat [
			Container { #borderWidth: 0 },
			Draw { #backgroundColor: #transparent } ] ]
]'
]

{ #category : 'private - factory' }
PhLMorphicConfiguration >> newStyleSheet [

	^ SpStyle defaultStyleSheet copy, (SpStyleVariableSTONReader fromString: self launcherStyle)
]
