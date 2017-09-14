accessing
sourcesFileUrlFor: anImageVersionString
	"$1: IMAGE_VERSION"
	^ 'http://files.pharo.org/get-files/{1}/sources.zip'
		format: {anImageVersionString}