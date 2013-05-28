interface building
buildBrowser
	browser := GLMTabulator new.
	browser
		column: #existingImages;
		column: #templateCategoriesColumn.
	browser transmit
		to: #existingImages;
		andShow: [ :a | self buildExistingImagesIn: a ].
	browser transmit
		to: #templateCategoriesColumn;
		andShow: [ :a | self buildTemplateCategoriesColumnIn: a ]