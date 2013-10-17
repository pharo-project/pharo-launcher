image action
deleteImages
	| images imageNames confirmMessage |
	images := self selectedImages.
	imageNames := images collect: [ :image | image name ].
	self flag: 'Workaround required until https://pharo.fogbugz.com/default.asp?11915 integrated'.
	imageNames size = 1 
		ifTrue: [ confirmMessage := 'Are you sure you want to delete ' ,  imageNames first asString ]
		ifFalse: [ confirmMessage := 'Are you sure you want to delete ' , (imageNames joinUsing: ', ' last: ' and ') ].
	(UIManager default confirm: (confirmMessage withNoLineLongerThan: 60) , '?')
		ifFalse: [ ^ self ].
	imageGroup deleteImages: images.
	self updateImages