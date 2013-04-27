as yet unclassified
addAll: window
	
	window
		addMorph: tab
		fullFrame: ((0 @ 0 corner: 1 @ 0) asLayoutFrame bottomOffset: 35).
				
	window
		addMorph: container
		fullFrame: (LayoutFrame identity topOffset: 35).
				
	tab tabs size = 0 ifTrue: [ ^ self ].
	tab color: Color white darker darker