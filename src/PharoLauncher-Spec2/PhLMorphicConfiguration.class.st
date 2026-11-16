"
I define the configuration for Pharo Launcher application on the Morphic backend.
I define styles making the Morphic UI look close to the Gtk (Adwaita) one, in light or dark.
When a launcher theme is set, I also switch the global UITheme to the matching Pharo theme.
"
Class {
	#name : 'PhLMorphicConfiguration',
	#superclass : 'SpMorphicConfiguration',
	#instVars : [
		'application'
	],
	#category : 'PharoLauncher-Spec2-Application',
	#package : 'PharoLauncher-Spec2',
	#tag : 'Application'
}

{ #category : 'configuring' }
PhLMorphicConfiguration >> applyUITheme [
	"Morphic widgets are drawn by the global UITheme: switch it to the launcher theme, if one is set"

	PharoLauncherSettings default uiThemeClass ifNil: [ ^ self ].
	(self isDarkTheme
		ifTrue: [ PharoDarkTheme ]
		ifFalse: [ PharoLightTheme ]) beCurrent
]

{ #category : 'configuring' }
PhLMorphicConfiguration >> configure: anApplication [

	super configure: anApplication.
	application := anApplication.
	self applyUITheme
]

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> darkPalette [
	"Colors from Adwaita dark theme"

	^ Dictionary new
		at: '@window' put: '#242424';
		at: '@view' put: '#38383C';
		at: '@selection' put: '#2C4A6E';
		at: '@dim' put: '#D3D3D3';
		at: '@accent' put: '#3584E4';
		yourself
]

{ #category : 'testing' }
PhLMorphicConfiguration >> isDarkTheme [

	^ PharoLauncherSettings default uiThemeClass
		ifNil: [ super isDarkTheme ]
		ifNotNil: [ :uiThemeClass | uiThemeClass uniqueInstance isDark ]
]

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> launcherStyle [

	^ self palette associations
		inject: self launcherStyleTemplate
		into: [ :style :color | style copyReplaceAll: color key with: color value ]
]

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> launcherStyleTemplate [
	"Mirror the classes used by the Gtk launcherStyle. @xxx are palette colors"

	^ '.application [
	.launcher [ Draw { #backgroundColor: @window } ],
	.label [
		.list_header [ Font { #name: EnvironmentFont(#default), #bold: true } ],
		.form_header [ Font { #name: EnvironmentFont(#default), #size: 12, #bold: true } ],
		.status_message [ Draw { #color: @dim } ] ],
	.table [
		Container { #rowHeight: 28, #borderWidth: 0 },
		Draw { #backgroundColor: @window, #selectionColor: @selection } ],
	.list [
		Container { #rowHeight: 28, #borderWidth: 0 },
		Draw { #backgroundColor: @window, #selectionColor: @selection } ],
	.tree [
		Container { #rowHeight: 28, #borderWidth: 0 },
		Draw { #backgroundColor: @window, #selectionColor: @selection } ],
	.textInputField [
		Container { #borderWidth: 0 },
		Draw { #color: @view } ],
	.text [
		Container { #borderWidth: 0 },
		Draw { #backgroundColor: @view } ],
	.code [ Draw { #backgroundColor: @view } ],
	.dropList [ Container { #borderWidth: 0 } ],
	.settings_form [
		Container { #borderWidth: 30, #borderColor: @window, #padding: 10 },
		Draw { #backgroundColor: @window } ],
	.welcomeThemeSelected [ Container { #borderWidth: 2, #borderColor: @accent } ],
	.actionButton [
		.flat [
			Container { #borderWidth: 0 },
			Draw { #backgroundColor: #transparent } ] ]
]'
]

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> lightPalette [
	"Colors from Adwaita light theme"

	^ Dictionary new
		at: '@window' put: '#FAFAFA';
		at: '@view' put: '#EBEBED';
		at: '@selection' put: '#CFE0F5';
		at: '@dim' put: '#9A9A9A';
		at: '@accent' put: '#3584E4';
		yourself
]

{ #category : 'private - factory' }
PhLMorphicConfiguration >> newStyleSheet [

	^ SpStyle defaultStyleSheet copy, (SpStyleVariableSTONReader fromString: self launcherStyle)
]

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> palette [

	^ self isDarkTheme
		ifTrue: [ self darkPalette ]
		ifFalse: [ self lightPalette ]
]

{ #category : 'private' }
PhLMorphicConfiguration >> notebooksIn: aWindowPresenter [

	^ aWindowPresenter adapter widget allMorphs select: [ :each | each isKindOf: SpNotebookMorph ]
]

{ #category : 'private' }
PhLMorphicConfiguration >> rebuild: aWindowPresenter [
	"Notebooks only select a page when displayed: keep their selected page"

	| pageIndexes |
	pageIndexes := (self notebooksIn: aWindowPresenter) collect: [ :each | each selectedPageIndex ].
	self updateWorldBorderOf: aWindowPresenter adapter widget.
	aWindowPresenter presenter in: [ :presenter | presenter layout: presenter layout ].
	(self notebooksIn: aWindowPresenter) withIndexDo: [ :notebook :index |
		notebook pages ifNotEmpty: [
			notebook selectedPageIndex: ((pageIndexes at: index ifAbsent: [ 1 ]) max: 1) ] ]
]

{ #category : 'configuring' }
PhLMorphicConfiguration >> switchTheme [
	"Morphs take some colors from the theme when built: rebuild the open windows"

	self applyUITheme.
	self styleSheet: self newStyleSheet.
	application ifNotNil: [
		application windows do: [ :each | self rebuild: each ] ]
]

{ #category : 'configuring' }
PhLMorphicConfiguration >> switchThemeToDark [

	self switchTheme
]

{ #category : 'configuring' }
PhLMorphicConfiguration >> switchThemeToLight [

	self switchTheme
]

{ #category : 'accessing - styles' }
PhLMorphicConfiguration >> syntaxHighlightTheme [

	^ self isDarkTheme
		ifTrue: [ 'Dark' ]
		ifFalse: [ super syntaxHighlightTheme ]
]

{ #category : 'private' }
PhLMorphicConfiguration >> updateWorldBorderOf: aMorph [
	"The world adapter only sets the world border color when built"

	aMorph isWorldMorph ifTrue: [ aMorph borderColor: aMorph theme backgroundColor ]
]
