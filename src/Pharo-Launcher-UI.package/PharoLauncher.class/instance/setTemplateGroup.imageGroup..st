initialization
setTemplateGroup: aTemplateRepository imageGroup: anImageGroup
	(self templatesMissingOnStartup or: self templatesClearedOnStartup)
		ifTrue: [ TemplateRepository := aTemplateRepository ].
	imageGroup := anImageGroup