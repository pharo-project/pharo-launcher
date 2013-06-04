accessing
templatesAndGroups
	| content matcher templates |
	content := ZnClient new
						url: url;
						beOneShot;
						accept: 'text/html;charset=utf-8' asZnMimeType;
						get.
	content := content readStream.
	matcher := RxMatcher for: self regex.
	templates := OrderedCollection new.
	 [ matcher searchStream: content ]
			whileTrue: [ self
									createTemplateFromHref: (matcher subexpression: self subexpression)
									addingTo: templates ].
	^ templates