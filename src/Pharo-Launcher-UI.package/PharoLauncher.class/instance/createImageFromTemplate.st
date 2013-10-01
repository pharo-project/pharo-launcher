template action
createImageFromTemplate
	| name   |
	name := UIManager default request: 'Image name?'.
	self showDownloadInProgress.
	self displayProgress: 'Downoading Image' during: [[UIManager default informUserDuring: [ :bar |
		[   imageGroup extractTemplate: self selectedTemplate to: name]
			on: HTTPProgress 
			do: [ :progress | 
				bar label: progress printString. 
				progress isEmpty ifFalse: [ bar current: progress percentage ].
				progress resume ] ]] on: PhLDownloadError
		do: [ :err | 
			UIManager default alert: err longDescription.
			^ self ]].
	
	self showNumberOfErrors.	
	self updateImages.
	self updateLocalTemplates.