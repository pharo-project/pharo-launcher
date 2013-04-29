downloading
download: anElement
	| fileToDownload |
	fileToDownload :=  (self imageDirectory / anElement name, 'zip').
	(fileToDownload exists)
		ifTrue: [ ^ self ]
		ifFalse: [ ZnClient new
			url: anElement url asString ;
			downloadTo: fileToDownload .  ].
	