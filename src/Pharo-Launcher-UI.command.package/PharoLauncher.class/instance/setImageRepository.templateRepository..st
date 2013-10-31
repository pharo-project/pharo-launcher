initialization
setImageRepository: aTemplateRepository templateRepository: anImageRepository
	(self templatesMissingOnStartup or: self templatesClearedOnStartup)
		ifTrue: [ TemplateRepository := aTemplateRepository ].
	imageRepository := anImageRepository