private
ensureSingleImageSelectedOr: failBlock 
	"failBlock will usually just be [ ^self ]."
	self selectedImages size = 1 ifFalse: 
	[ 	UIManager default inform: 'Action requires single selection.' . 
		failBlock value. 
	].	 
