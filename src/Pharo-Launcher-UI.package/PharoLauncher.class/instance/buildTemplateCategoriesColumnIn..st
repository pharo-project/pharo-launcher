interface building
buildTemplateCategoriesColumnIn: constructor
	constructor tabulator
		with: [ :t | 
			t
				title: 'Templates';
				row: #templateCategories span: 3;
				row: #templateDescription.
			t transmit
				to: #templateCategories;
				andShow: [ :a | self buildTemplateCategoriesIn: a ].
			t transmit
				from: #templateCategories;
				to: #templateDescription;
				andShow: [ :a | self buildTemplateDescriptionIn: a ] ]