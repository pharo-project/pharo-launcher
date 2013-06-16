updating
updateImages
	| images |
	images := imageGroup images sorted: [ :im1 :im2 | im1 name < im2 name ].
	imagesModel roots: images