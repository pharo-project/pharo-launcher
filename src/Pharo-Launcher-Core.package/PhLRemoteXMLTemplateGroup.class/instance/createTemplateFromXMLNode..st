remote action
createTemplateFromXMLNode: each
	| tmpCategories tmpUrl tmpName template |
	tmpName := (each nodes elementAt: #name) nodes first string.
	tmpUrl := (each nodes elementAt: #url) nodes first string.
	tmpCategories := Array with: (each nodes elementAt: #category) nodes first string.
	template := PhLRemoteTemplate name: tmpName url: tmpUrl categories: tmpCategories.
	^ template