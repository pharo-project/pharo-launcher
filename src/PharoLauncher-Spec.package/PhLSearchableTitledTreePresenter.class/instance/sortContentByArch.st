private - filtering
sortContentByArch 

	self sortTreeWith: [:image1 :image2 | image1 arch > image2 arch ]
	