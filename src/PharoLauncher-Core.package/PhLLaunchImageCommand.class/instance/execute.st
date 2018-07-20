action
execute
	self model hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]