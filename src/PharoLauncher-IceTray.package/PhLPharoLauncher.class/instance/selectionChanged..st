actions
selectionChanged: anAnnouncement

	imagesTable morph selectedItems size = 1 ifTrue: [ 
		propertyPanel model: imagesTable morph selectedItems anyOne ].