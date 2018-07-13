instance creation
newMainPanel
	| panel |
	panel := super  newMainPanel.
	self newTickBoxRow ifNotNil: [:m | panel addMorphBack: m ].
	^ panel