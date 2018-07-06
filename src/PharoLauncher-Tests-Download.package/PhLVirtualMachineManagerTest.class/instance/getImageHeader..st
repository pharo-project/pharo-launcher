utility
getImageHeader: anImageUrl
	| archive image |
	archive := ZipArchive new 
		readFrom: (ZnEasy get: anImageUrl) contents readStream.
	image:= archive members detect: [ :each | each  fileName endsWith: '.image' ].
	^ ((image contentsFrom: 1 to: 4) collect: #asciiValue as: Array) readStream
