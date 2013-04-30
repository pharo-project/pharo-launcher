as yet unclassified
category: aString 
	"Default directory where a .xml should be there, doesn't matter about the string ... for the moment..."
	^ self category: aString 
		url: (self imageDirectory / 'templates') ensureDirectory 