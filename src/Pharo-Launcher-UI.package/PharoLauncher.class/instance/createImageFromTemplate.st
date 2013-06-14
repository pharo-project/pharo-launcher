template action
createImageFromTemplate
	| name |
	name := UIManager default request: 'Image name?'.
	self showDownloadInProgress.
	[ imageGroup extractTemplate: self selectedTemplate to: name ]
		on: PhLDownloadError
		do: [ :err | 
			UIManager default alert: err longDescription.
			^ self ].
	self updateAll