as yet unclassified
menuCommandOn: aBuilder 
	<worldMenu> 

	(aBuilder item: #'Pharo Launcher')
		icon: self pharoIcon16x16;
		action: [ self open ].
	aBuilder withSeparatorAfter.	 
		  