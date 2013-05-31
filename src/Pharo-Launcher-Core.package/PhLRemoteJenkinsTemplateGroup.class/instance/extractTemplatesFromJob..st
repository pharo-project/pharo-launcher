accessing
extractTemplatesFromJob: job
	^ job artifacts
		inject: OrderedCollection new
		into: [ :templates :artifact | 
			"All files with a zip extension are considered image templates.
			 Don't know what else I could do."
			(artifact fileExtension = 'zip')
				ifTrue: [
					templates add: (PhLRemoteTemplate
												name: artifact fullName
												url: artifact url
												categories: self categories) ].
			templates ]