accessing
images
	images := OrderedCollection new.
	self baseDirectory directories
		do: [ :directory | (self initializeImageFrom: directory)
											ifNotNil: [ :image | images add: image ] ].
	^ images