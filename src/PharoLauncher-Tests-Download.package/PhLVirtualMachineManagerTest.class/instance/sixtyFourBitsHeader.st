input data
sixtyFourBitsHeader
	" too long to process this request
		^ self getImageHeader: 'http://files.pharo.org/image/60/latest-64.zip'
	"	
	" Retrieved with:
		'pharo64.image' asFileReference binaryReadStream next: 20
	"
	
	^ #[181 9 1 0 128 0 0 0 112 37 248 2 0 0 0 0 0 64 128 0] readStream "truncated image file"