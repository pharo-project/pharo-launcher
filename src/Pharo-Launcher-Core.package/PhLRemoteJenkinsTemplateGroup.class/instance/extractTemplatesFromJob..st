accessing
extractTemplatesFromJob: job
	| fileUrls |
	fileUrls := job files.
	^ fileUrls
		inject: OrderedCollection new
		into: [ :templates :fileUrl | 
			| filename |
			filename := fileUrl lastPathSegment.
			"All files with a zip extension are considered image templates.
			 Don't know what else I could do."
			(filename endsWith: '.zip')
				ifTrue: [
					templates add: (PhLRemoteTemplate
												name: (filename allButLast: '.zip' size)
												url: fileUrl
												categories: self categories) ].
			templates ]