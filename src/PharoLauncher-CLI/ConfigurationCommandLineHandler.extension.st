Extension { #name : #ConfigurationCommandLineHandler }

{ #category : #'*PharoLauncher-CLI' }
ConfigurationCommandLineHandler >> handleMergeConflictDuring: aLoadBlock [
	[aLoadBlock 
	on: MCMergeOrLoadWarning do: [ :mergeConflict | mergeConflict load ]]
	on: MCMergeResolutionRequest do: [ :request |  request autoMerge ].
]
