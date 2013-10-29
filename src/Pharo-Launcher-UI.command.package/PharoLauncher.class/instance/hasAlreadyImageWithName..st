private
hasAlreadyImageWithName: newName
	"Return true if we already have an image with the given name"
	
	^(self allImages select: [:each | each name = newName ]) notEmpty 