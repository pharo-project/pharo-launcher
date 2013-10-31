accessing
artifacts
	^ (json at: #artifacts)
		collect: [ :jsonArtifact | 
			PhLJenkinsArtifact
					name: self name
					url: self url / 'artifact' / (jsonArtifact at: #relativePath)
					options: self options ]