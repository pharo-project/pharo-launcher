image action
launchImage
	self ensureSingleImageSelectedOr: [ ^self ].
	self selectedImage launch.
	self quitOnLaunch ifTrue: [ self quit ].