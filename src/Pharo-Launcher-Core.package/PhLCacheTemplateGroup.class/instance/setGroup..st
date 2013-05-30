initialize-release
setGroup: templateGroup
	delegate := templateGroup.
	templateCategoryMap := Dictionary new.
	self templates
		do: [ :template | 
			template categories
				do: [ :category | 
					templateCategoryMap
						at: category
						ifPresent: [ :list | list add: template ]
						ifAbsent: [ 
							| list |
							list := OrderedCollection new.
							list add: template.
							templateCategoryMap at: category put: list ] ] ]