private
fetchSourcesFiles
	"Download sources file of the current version AND sources file of the previous version in case the image was an alpha version.
	Do not download sources for Pharo versions > 70 as they come along with the image."
	(self imageVersion asInteger < 70)
		ifTrue: [ self fetchSourcesFilesFor: self imageVersion.
					self fetchSourcesFilesFor: (self imageVersion asInteger - 10) asString ]