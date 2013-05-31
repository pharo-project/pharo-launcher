Take care of caching for all subclasses of PhLAbstractTemplateGroup. 

Instance Variables
	categories:		a collection of categories (= the keys of templateCategoryMap)
	delegate:		a PhLAbstractTemplateGroup (in most cases a PhLTemplateRepository)
	templateCategoryMap:		a dictionary mapping categories to a list of templates which are included in this category
	templates:		all the templates of my delegate (= the values of templateCategoryMap) 
