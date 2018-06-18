action
execute
	context hasSingleImageSelected
		ifTrue: [ self launchSelectedImage ]
		ifFalse: [ self launchImageFromDisk ]