initialization
initializeWidgets

	nameLabel := self newLabel label: 'name:'.
	nameTextInput := self newTextInput autoAccept: true.

	vmLabel := self newLabel label: 'VM version:'.
	vmInput := self newTextInput autoAccept: true.

	templateLabel := self newLabel label: 'template:'.
	templateInput := self newTextInput autoAccept: true.

	lastModificationLabel := self newLabel label: 'modified:'.
	lastModificationInput := self newTextInput autoAccept: true.

	tagsLabel := self newLabel label: 'tags:'.
	tagsInput := self newTextInput autoAccept: true.

	commentLabel := self newLabel label: 'comment:'.
	commentInput := self newTextInput autoAccept: true.

	locationLabel := self newLabel label: 'location:'.
	locationInput := self newTextInput autoAccept: true.

	
	self focusOrder 
		add: nameTextInput;
		add: vmInput;
		add: templateInput;
		add: locationInput;
		add: lastModificationInput;
		add: tagsInput;
		add: commentInput.
		