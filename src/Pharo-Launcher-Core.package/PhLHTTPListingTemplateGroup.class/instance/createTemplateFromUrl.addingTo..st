accessing
createTemplateFromUrl: filename addingTo: templates
	| fileUrl templateName |
	fileUrl := url / filename.
	templateName := filename copyUpTo: $..
	templates add: (PhLRemoteTemplate name: templateName  url: fileUrl categories: categories)