accessing
images
	| images |
    Transcript crShow:
        thisContext printString, ' <-- ' ,
        thisContext sender printString , ' <-- ' ,
        thisContext sender sender printString , ' <-- ' ,
        thisContext sender sender sender printString .
	images := OrderedCollection new.
	self baseDirectory directories
		do: [ :directory | (self imageFromDirectory: directory) ifNotNil: [ :image | images add: image ] ].
	^ images