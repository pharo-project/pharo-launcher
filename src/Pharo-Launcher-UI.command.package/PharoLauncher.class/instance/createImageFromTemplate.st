template action
createImageFromTemplate
	| name |
	name := imageGroup makeUniqueImageName: self selectedTemplate name.
	name := UIManager default request: 'Image name?' initialAnswer: name.
	name ifNil: [ ^ self ].
	self showDownloadInProgress.
	self
		displayProgress: 'Downoading Image'
		during: [ 
			[ 
			UIManager default
				informUserDuring: [ :bar | 
					[ imageGroup extractTemplate: self selectedTemplate to: name ]
						on: HTTPProgress
						do: [ :progress | 
							bar label: progress printString.
							progress isEmpty
								ifFalse: [ bar current: progress percentage ].
							progress resume ] ] ]
				on: PhLDownloadError
				do: [ :err | 
					UIManager default alert: err longDescription.
					^ self ] ].
	self showNumberOfErrors.
	self updateImages.
	self refreshLocalTemplateGroups