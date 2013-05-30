accessing
artifactsFromJson: jsonArtifacts
	^ jsonArtifacts 
		ifNil: [ #() ]
		ifNotNil: [ jsonArtifacts collect: [ :jsonArtifact |
				PhLJenkinsArtifact
					name: name
					url: url / (jsonArtifact at: #relativePath) ] ]