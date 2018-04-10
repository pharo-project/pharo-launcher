action
deleteImages: someImages
	self dontNotifyDuring: [ someImages do: [ :image | self deleteImage: image ] ].
	self contentsChanged