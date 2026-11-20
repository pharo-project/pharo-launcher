Extension { #name : 'RubAbstractTextArea' }

{ #category : '*PharoLauncher-SpecPatches-RubricTextAreaThemeChanged' }
RubAbstractTextArea >> themeChanged [

	(self decoratorNamed: #shoutStyler) ifNotNil: [ :styler |
		styler refreshStyling
	].

	self class backgroundColor: self theme backgroundColor.
	"In a scroll pane, the scroll pane draws the background (see #scrollPane:)"
	self color: (scrollPane
			 ifNil: [ self defaultColor ]
			 ifNotNil: [ Color transparent ]).
	super themeChanged
]
