accessing
templatesAndGroups
	| content matcher templates |
	content := PhLDownloadManager default downloadToPositionableStream: url.
	matcher := RxMatcher for: self regex.
	templates := OrderedCollection new.
	 [ matcher searchStream: content ]
			whileTrue: [ self
									createTemplateFromHref: (matcher subexpression: self subexpression)
									addingTo: templates ].
	^ templates