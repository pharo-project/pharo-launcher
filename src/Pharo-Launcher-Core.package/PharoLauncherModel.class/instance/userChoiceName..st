runnnig
userChoiceName: anElement
	| widget |
	
	widget := InputWidget new;
		title: 'Choice project name';
		label: 'Project name?';
		ghostText: ''.

	World openModal: widget openDialogWithSpec window.

	(widget value contents asString = '')
		ifTrue: [ ^ self userChoiceName: anElement ].
		self rename: (self tmpDirectory: anElement) 
			to: widget value contents asString.
		self move: (widget value contents asString, '.image') 
			from: (self tmpDirectory: anElement) 
			to: self imageDirectory pathString.
		self move: (widget value contents asString, '.changes') 
			from: (self tmpDirectory: anElement) 
			to: self imageDirectory pathString.
		^ widget value contents asString.
	