action
import: imagePath
	| infoMessage destFolderName |
	destFolderName := imagePath asFileReference basenameWithoutExtension.
	importSiblings 
		ifTrue: [ context imageRepository
			importImageNamed: imagePath
			 andSiblingFilesto: destFolderName ]
		ifFalse: [ context imageRepository
			importImageNamed: imagePath
			to: destFolderName ].
	infoMessage := 'Image ' , imagePath , ' imported!'.
	MessageDialogWindow new
		message: (infoMessage withNoLineLongerThan: 60)