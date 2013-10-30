image action
deleteImages
	| images imageNames confirmMessage |
	images := self selectedImages.
	imageNames := images collect: [ :image | image name ].
	confirmMessage := 'Are you sure you want to delete ' , (imageNames joinUsing: ', ' last: ' and ').
	(UIManager default confirm: (confirmMessage withNoLineLongerThan: 60) , '?')
		ifFalse: [ ^ self ].
	imageGroup deleteImages: images.
	self updateImages