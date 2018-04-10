input data
thirtyTwoBitsHeader
	" too long to process this request
		^ self getImageHeader: 'http://files.pharo.org/image/60/latest.zip'
	"	
	" Retrieved with:
		'pharo.image' asFileReference binaryReadStream next: 20
	"
	^ #[121 25 0 0 64 0 0 0 8 84 50 2 112 76 76 10 216 156 254 11] readStream "truncated image file"