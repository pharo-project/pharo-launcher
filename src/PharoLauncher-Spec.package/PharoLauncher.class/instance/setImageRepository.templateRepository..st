initialization
setImageRepository: anImageRepository templateRepository: aTemplateRepository
	(self templatesMissingOnStartup or: self templatesClearedOnStartup)
		ifTrue: [ TemplateRepository := aTemplateRepository ].
	imageRepository := anImageRepository