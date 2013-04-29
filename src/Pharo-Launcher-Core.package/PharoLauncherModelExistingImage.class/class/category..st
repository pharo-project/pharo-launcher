as yet unclassified
category: aString 
	"Default directory where a .xml should be there"
	^ self category: aString 
		url: ( StartupLoader preferencesGeneralFolder asFileReference / SystemVersion current dottedMajorMinor )