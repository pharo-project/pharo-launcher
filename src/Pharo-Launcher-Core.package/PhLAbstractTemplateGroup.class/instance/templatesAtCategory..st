accessing
templatesAtCategory: aCategory
	^ self templates select: [ :template | template categories includes: aCategory ]