action
import: imagePath
	| infoMessage destFolderName |
	destFolderName := imagePath asFileReference basenameWithoutExtension.
	importSiblings 
		ifTrue: [ self model imageRepository
			importImageNamed: imagePath
			 andSiblingFilesto: destFolderName ]
		ifFalse: [ self model imageRepository
			importImageNamed: imagePath
			to: destFolderName ].
	infoMessage := 'Image ' , imagePath , ' imported!'.
	self inform: (infoMessage withNoLineLongerThan: 60) 