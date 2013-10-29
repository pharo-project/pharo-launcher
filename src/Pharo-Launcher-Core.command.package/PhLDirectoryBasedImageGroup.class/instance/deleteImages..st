action
deleteImages: someImages 
	someImages do: [ :image | self deleteImage: image ]