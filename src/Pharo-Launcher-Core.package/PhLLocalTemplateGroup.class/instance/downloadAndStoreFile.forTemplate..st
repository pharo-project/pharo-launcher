action
downloadAndStoreFile: anUrl forTemplate: aRemoteTemplate 
	| response |
	response := ZnClient new
		url: anUrl;
		downloadTo: self baseDirectory.
	response ifFalse: [ Error signal: 'Can''t download file' ].
	^ self baseDirectory / anUrl asZnUrl lastPathSegment