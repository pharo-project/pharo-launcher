accessing
roots
	^ self images sorted: [ :image1 :image2 | image1 name asUppercase < image2 name asUppercase ]