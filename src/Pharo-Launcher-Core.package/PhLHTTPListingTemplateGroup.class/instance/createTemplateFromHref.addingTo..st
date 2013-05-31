private
createTemplateFromHref: filename addingTo: templates
	| templateName |
	templateName := filename copyUpTo: $..
	templates add: (PhLRemoteTemplate name: templateName url: url / filename categories: categories)