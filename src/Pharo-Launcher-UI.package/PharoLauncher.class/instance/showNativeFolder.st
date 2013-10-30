image action
showNativeFolder
	| image |
	self ensureSingleImageSelectedOr: [ ^ self ].
	image := self selectedImage.
	image showNativeFolder