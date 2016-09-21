private - accessing
searchField
	
	^ SearchMorph new
		model: self;
		setIndexSelector: #searchAccept:; 
		updateSelector: #searchAccept:;
		acceptSelector: #searchAccept:;
		searchList: OrderedCollection new;
		asSpecAdapter