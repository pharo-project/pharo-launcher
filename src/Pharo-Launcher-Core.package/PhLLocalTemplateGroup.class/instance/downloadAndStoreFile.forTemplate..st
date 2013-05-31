action
downloadAndStoreFile: anUrl forTemplate: aRemoteTemplate
	| response destinationFile fileExtension |
	fileExtension := anUrl lastPathSegment copyAfterLast: $..
	destinationFile := self baseDirectory / aRemoteTemplate name , fileExtension.
	response := ZnClient new
		url: anUrl;
		downloadTo: destinationFile.
	response
		ifFalse: [ Error signal: 'Can''t download file' ].
	self register: aRemoteTemplate withZip: destinationFile.
	^ destinationFile