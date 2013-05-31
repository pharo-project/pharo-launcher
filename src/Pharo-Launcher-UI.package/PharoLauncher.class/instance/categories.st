interface building
categories
	"Return a 'sorted' collection of all the categories for all the tempaltes. Put the most used ones first and sort the rest alphabetically"
	| allCategories mostUsedCategories otherCategories |
	allCategories := templateGroupCache categories.
	mostUsedCategories := Array with: PhLLocalTemplateGroup default category.
	mostUsedCategories := mostUsedCategories intersection: allCategories.
	otherCategories := allCategories copyWithoutAll: mostUsedCategories.
	^ mostUsedCategories , otherCategories sorted