instance creation
newFromJson: aJsonObject 
	^ self new
			setName: (aJsonObject at: #name)
			url: (aJsonObject at: #url) asZnUrl
			