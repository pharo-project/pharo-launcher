private - filtering
sortContentByTemplate 

	self sortTreeWith: [:item1 :item2 | item1 originTemplateName > item2 originTemplateName ]
	