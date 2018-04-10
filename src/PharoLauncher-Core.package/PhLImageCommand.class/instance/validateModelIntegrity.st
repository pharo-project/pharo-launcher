testing
validateModelIntegrity
	| missingImages |
	
	missingImages := context selectedImages reject: [ :img | img file exists ].
	
	^ missingImages ifEmpty: [ true ] ifNotEmpty: [ 
		|names|
		names := (missingImages collect: #name) joinUsing: ',' last: ' and '. 
		context newInformation 
				message: 'Unable to ', self class title, ': ', names, '! (File not found)'; 
				abort.
		context imageRepository contentsChanged.
		false ]