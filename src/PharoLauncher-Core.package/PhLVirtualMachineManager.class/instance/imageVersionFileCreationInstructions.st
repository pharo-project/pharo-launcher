private
imageVersionFileCreationInstructions
	"Pharo 6 images >= 60509 need 61 VM, even though the image states 60"
	^ '(Smalltalk imagePath asFileReference parent) / ''{1}'' 
		writeStreamDo: [ :stream | |major minor|
			major := SystemVersion current major.
			minor := SystemVersion current minor.
			(major = 6 and: [ SystemVersion current highestUpdate >= 60509 ])
				ifTrue: [ minor := 1 ].
			stream 
				<< major asString;
				<< minor asString ]'
		format: { self imageVersionFileName }