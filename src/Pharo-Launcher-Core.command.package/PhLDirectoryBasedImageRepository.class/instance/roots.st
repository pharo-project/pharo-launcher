accessing
roots
	| images |
	images := OrderedCollection new.
	self baseDirectory directories
		do: [ :directory | (self imageFromDirectory: directory) ifNotNil: [ :image | images add: image ] ].
	^ images