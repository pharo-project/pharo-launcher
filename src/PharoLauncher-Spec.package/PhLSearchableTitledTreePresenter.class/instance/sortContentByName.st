private - filtering
sortContentByName

	self sortTreeWith: [:item1 :item2 |
		item1 printString < item2 printString]
	