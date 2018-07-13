private - filtering
sortContentByDateModfied 

	self sortTreeWith: [:item1 :item2 |
		item1 file modificationTime > item2 file modificationTime]
	