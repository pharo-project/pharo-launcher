testing
validateModelIntegrity
	| missingImages |
	
	missingImages := self model selectedImages reject: [ :img | img file exists ].
	
	^ missingImages ifEmpty: [ true ] ifNotEmpty: [ 
		|names|
		names := (missingImages collect: #name) joinUsing: ',' last: ' and '. 
		self model newInformation 
				message: 'Unable to ', self class title, ': ', names, '! (File not found)'; 
				abort.
		self model imageRepository contentsChanged.
		false ]