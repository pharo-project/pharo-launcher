action
import: imagePath
	| infoMessage |
	context imageRepository
		importImageNamed: imagePath
		to: imagePath asFileReference basenameWithoutExtension.
	infoMessage := 'Image ', imagePath, ' imported!'.
	MessageDialogWindow  new 
		message: (infoMessage withNoLineLongerThan: 60).