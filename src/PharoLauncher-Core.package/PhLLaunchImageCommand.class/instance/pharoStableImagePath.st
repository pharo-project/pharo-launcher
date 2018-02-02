accessing
pharoStableImagePath
	| img |
	img := (self resourcesPath  / 'images' / 'pharo-stable.zip') asFileReference.
	^ img exists 
		ifTrue: [ img ]
		ifFalse: [ nil ]