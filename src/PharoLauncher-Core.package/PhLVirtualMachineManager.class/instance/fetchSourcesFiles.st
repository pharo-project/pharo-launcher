private
fetchSourcesFiles
	"Do not download sources for Pharo versions > 70 as they come along with the image."
	self imageVersion asInteger >= 70
		ifTrue: [ ^ self ].
	self fetchSourcesFilesFor: self imageVersion