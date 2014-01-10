private
askConfirmation
	| confirmMessage |
	
	confirmMessage := 'Are you sure you want to refresh this image?' , Character cr asString, 
							'It will override the existing image and you may loose changes.'.
	^ context newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.