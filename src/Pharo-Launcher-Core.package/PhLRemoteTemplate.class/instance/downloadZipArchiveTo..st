actions
downloadZipArchiveTo: aDirectory
	| response |
	response := ZnClient new
		url: url;
		downloadTo: aDirectory.
	response ifFalse: [ Error signal: 'Can''t download file' ].
	^ aDirectory / url asZnUrl lastPathSegment