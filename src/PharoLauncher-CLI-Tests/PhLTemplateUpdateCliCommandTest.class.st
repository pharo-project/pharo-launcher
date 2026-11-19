Class {
	#name : 'PhLTemplateUpdateCliCommandTest',
	#superclass : 'PhLTemplatesCliCommandTest',
	#category : 'PharoLauncher-CLI-Tests-Commands',
	#package : 'PharoLauncher-CLI-Tests',
	#tag : 'Commands'
}

{ #category : 'tests' }
PhLTemplateUpdateCliCommandTest >> testTemplateUpdateDoesNotSubscribeToSharedAnnouncer [
	| command workingDir |

	workingDir := FileSystem memory root.
	self launcherModel templateRepository: (PhLTemplateGroupRepository newFromGroups: #()).
	
	PhLTemplateSources useLauncherCoreDir: workingDir during: [ 
		PhLTemplateSources flush: #() in: workingDir / PhLTemplateSources sourcesFileName.
		command := (self context arguments: #('launcher' 'template' 'update')) command.
		command execute ].

	self deny: (PhLTemplateSourcesAnnouncer default hasSubscriber: command)
]

{ #category : 'tests' }
PhLTemplateUpdateCliCommandTest >> testTemplateUpdateShouldSucceed [
	| command workingDir publishedSources rootNames |

	workingDir := FileSystem memory root.
	self launcherModel templateRepository: (PhLTemplateGroupRepository newFromGroups: #()).
	publishedSources := OrderedCollection
		with: PhLTemplateSource moocGroup
		with: PhLTemplateSource pharo60.
	
	PhLDownloadManagerMock during: [ :mock |
		mock defaultResponse: (STON toStringPretty: publishedSources).
		PhLTemplateSources useLauncherCoreDir: workingDir during: [ 
			PhLTemplateSources flush: #() in: workingDir / PhLTemplateSources sourcesFileName.
			command := (self context arguments: #('launcher' 'template' 'update')) command.
			self assert: command pharoLauncherModel templateRepository roots size equals: 0.
		
			command execute.
			rootNames := command pharoLauncherModel templateRepository roots collect: #name ] ].

	self
		assert: rootNames asArray
		equals: (publishedSources collect: #name) asArray
]
