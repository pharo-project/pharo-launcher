accessing
artifactsFromJson: jsonArtifacts
	^ jsonArtifacts 
		ifNil: [ #() ]
		ifNotNil: [ jsonArtifacts collect: [ :jsonArtifact |
				PhLJenkinsArtifact
					name: self name
					url: self url / 'lastSuccessfulBuild' / 'artifact' / (jsonArtifact at: #relativePath) ] ]