interface building
buildBrowser
	browser := GLMTabulator new.
	browser
		column: #imagesColumn;
		column: #templateColumn.
	browser transmit
		to: #imagesColumn;
		andShow: [ :a | self buildImagesColumnIn: a ].
	browser transmit
		to: #templateColumn;
		transformed: [ templateRepository groups ];
		andShow: [ :a | self buildTemplateColumnIn: a ]