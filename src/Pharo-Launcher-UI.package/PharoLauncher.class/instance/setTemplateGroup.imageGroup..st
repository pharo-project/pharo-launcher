initialization
setTemplateGroup: aTemplateRepository imageGroup: anImageGroup
	(self class templatesClearedOnStartup or: [ TemplateRepository isNil ] )
		ifTrue: [ TemplateRepository := aTemplateRepository ].
	imageGroup := anImageGroup