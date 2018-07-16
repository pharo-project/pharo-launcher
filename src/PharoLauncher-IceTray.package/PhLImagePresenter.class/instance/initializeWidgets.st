initialization
initializeWidgets

	nameLabel := self newLabel label: 'name:'.
	nameTextInput := self newTextInput autoAccept: true.
	nameTextInput enabled: false.

	vmLabel := self newLabel label: 'VM version:'.
	vmInput := self newTextInput autoAccept: true.
	vmInput enabled: false.
	
	templateLabel := self newLabel label: 'template:'.
	templateInput := self newTextInput autoAccept: true.
	templateInput enabled: false.
	

	lastModificationLabel := self newLabel label: 'modified:'.
	lastModificationInput := self newTextInput autoAccept: true.
	lastModificationInput enabled: false.
	
	tagsLabel := self newLabel label: 'tags:'.
	tagsInput := self newTextInput autoAccept: true.
	tagsInput enabled: false.

	commentLabel := self newLabel label: 'comment:'.
	commentInput := self newTextInput autoAccept: true.
	commentInput enabled: false.

	locationLabel := self newLabel label: 'location:'.
	locationInput := self newTextInput autoAccept: true.
	locationInput enabled: false.
	
	self focusOrder 
		add: nameTextInput;
		add: vmInput;
		add: templateInput;
		add: locationInput;
		add: lastModificationInput;
		add: tagsInput;
		add: commentInput.
		