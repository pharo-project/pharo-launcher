downloading
download: anElement
	| fileToDownload |
	fileToDownload :=  (self imageDirectory / anElement name, 'zip').
	(fileToDownload exists)
		ifTrue: [ ^ self ].
	ZnClient new
		url: anElement url asString ;
		downloadTo: fileToDownload . 
	