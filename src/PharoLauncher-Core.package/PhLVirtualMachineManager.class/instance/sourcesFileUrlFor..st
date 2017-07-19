accessing
sourcesFileUrlFor: anImageVersionString
	"$1: IMAGE_VERSION"
	^ 'http://files.pharo.org/sources/PharoV{1}.sources'
		format: { anImageVersionString }