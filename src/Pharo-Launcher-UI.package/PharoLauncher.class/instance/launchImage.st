image action
launchImage
	self ensureSingleImageSelectedOr: [ ^self ].
	self selectedImage launch.
	self quit