action
downloadAndStoreFile: anUrl forTemplate: aRemoteTemplate
	"Download the file at anUrl (hopefully a zip archive), put it in my cache, and update the meta-data file (using information from aRemoteTemplate). If everything went well, a reference to the downloaded file is returned"
	| response destinationFile fileExtension |
	"We want to keep the same extension..."
	fileExtension := anUrl lastPathSegment copyAfterLast: $..
	"...but change the file name to be the one of aRemoteTemplate"
	destinationFile := self baseDirectory / aRemoteTemplate name , fileExtension.
	response := ZnClient new
		url: anUrl;
		downloadTo: destinationFile.
	response
		ifFalse: [ Error signal: 'Can''t download file' ].
	self register: aRemoteTemplate withZip: destinationFile.
	^ destinationFile