private
createTemplateFromHref: filename addingTo: templates
	| templateName |
	templateName := filename copyUpToLast: $..
	templates add: (PhLRemoteTemplate name: templateName url: url / filename)