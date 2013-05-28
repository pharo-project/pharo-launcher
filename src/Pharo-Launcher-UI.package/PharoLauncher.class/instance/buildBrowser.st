interface building
buildBrowser
	browser := GLMTabulator new.
	browser
		column: #recentImages;
		column: #templateCategoriesColumn.
	browser transmit
		to: #recentImages;
		andShow: [ :a | self buildRecentImagesIn: a ].
	browser transmit
		to: #templateCategoriesColumn;
		andShow: [ :a | self buildTemplateCategoriesColumnIn: a ]