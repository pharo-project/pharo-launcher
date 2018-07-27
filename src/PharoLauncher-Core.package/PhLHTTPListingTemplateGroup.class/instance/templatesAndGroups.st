accessing
templatesAndGroups
	| content matcher templates |
	content := PhDDownloadManager default downloadToPositionableStream: url mimeType: ZnMimeType textHtml. 
	matcher := RxMatcher for: self regex.
	templates := OrderedCollection new.
	[ matcher searchStream: content ] whileTrue: 
		[ self createTemplateFromHref: (matcher subexpression: self subexpression)  addingTo: templates ].
	^ templates
	