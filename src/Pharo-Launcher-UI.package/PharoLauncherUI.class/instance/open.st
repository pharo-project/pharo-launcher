instance creation
open

	| window panel |
	window := StandardWindow new.
	panel := PanelMorph new hResizing: #spaceFill; vResizing: #spaceFill; changeProportionalLayout.

	window addMorph: panel frame: (0@0 corner: 1@1).
	self addAll: panel.
	window openInWorld.
	
	window title: 'Pharo Launcher'.
	window maximize.