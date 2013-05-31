accessing
templatesAtCategory: aCategory
	"Return the subset of all my templates that are in aCategory"
	^ self templates select: [ :template | template categories includes: aCategory ]