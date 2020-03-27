Extension { #name : #SpTablePresenterTest }

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
SpTablePresenterTest >> testGivenSortingIsActiveWhenAffectingNewItemsThenNewItemsAreSorted [
	[ presenter
		addColumn: (SpStringTableColumn title: ' i ' evaluated: #value);
		addColumn: (SpStringTableColumn title: ' 1 / i ' evaluated: [ :item | (1 / item) value ]);
		openWithSpec;
		selectIndex: 1.
		
	"sort by 1/i ascending"
	presenter clickOnColumnHeaderAt: 2.

	presenter
		items: #(40 50); 
		selectIndex: 1.
	
	self assert: presenter selection selectedItem equals: 50 "items are still sorted by 1/i ascending value" ]
		ensure: [ presenter delete ]
]
