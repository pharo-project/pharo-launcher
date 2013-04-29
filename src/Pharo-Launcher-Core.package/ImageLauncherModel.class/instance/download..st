downloading
download: anElement
	| fileToDownload |
	fileToDownload :=  (StartupLoader preferencesGeneralFolder asFileReference / SystemVersion current dottedMajorMinor / anElement name, 'zip').
	(fileToDownload exists)
		ifTrue: [ ^ self ]
		ifFalse: [ ZnClient new
			url: anElement url asString ;
			downloadTo: fileToDownload .  ].
	