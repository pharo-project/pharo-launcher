private
fetchSourcesFiles
	"Download sources file of the current version AND sources file of the previous version in case the image was an alpha version."
	self fetchSourcesFilesFor: self imageVersion.
	self fetchSourcesFilesFor: (self imageVersion asInteger - 10) asString