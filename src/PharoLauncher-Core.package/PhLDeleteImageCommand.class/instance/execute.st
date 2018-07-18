action
execute
	| images imageNames confirmMessage answer |
	images := self model selectedImages.
	imageNames := images collect: #name.
	confirmMessage := 'Are you sure you want to delete ' , (imageNames joinUsing: ', ' last: ' and ').
	answer := self model newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.
	answer
		ifTrue: [ self model imageRepository deleteImages: images ]