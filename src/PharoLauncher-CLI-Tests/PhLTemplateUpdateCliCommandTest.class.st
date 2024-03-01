Class {
	#name : #PhLTemplateUpdateCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateUpdateCliCommandTest >> testTemplateUpdateShouldSucceed [
	| command workingDir |

	workingDir := FileSystem memory root.
	self launcherModel templateRepository: (PhLTemplateGroupRepository newFromGroups: #()).
	
	PhLTemplateSources useLauncherCoreDir: workingDir during: [ 
		PhLTemplateSources flush: #() in: workingDir / PhLTemplateSources sourcesFileName.
		command := (context arguments: #('launcher' 'template' 'update')) command.
		self assert: command pharoLauncherModel templateRepository roots size equals: 0.
		
		command execute ].

	"self assertSuccess."
	self assert:( workingDir / 'sources.list') exists.
	self assert: command pharoLauncherModel templateRepository roots size equals: 8
]
