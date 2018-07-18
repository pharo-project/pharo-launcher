actions
firstlySelectedImage

	^ imagesTable morph selectedItems size = 1 
		ifTrue: [ imagesTable morph selectedItems anyOne ]
		ifFalse: [ nil ]