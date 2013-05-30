accessing
templatesAtCategory: aCategory
	^ templateCategoryMap at: aCategory ifAbsent: [ #() ]