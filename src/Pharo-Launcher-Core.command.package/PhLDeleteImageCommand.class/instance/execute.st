action
execute
	| images imageNames confirmMessage answer |
	images := context selectedImages.
	imageNames := images collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (imageNames joinUsing: ', ' last: ' and ').
	answer := context newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ context imageRepository deleteImages: images ]