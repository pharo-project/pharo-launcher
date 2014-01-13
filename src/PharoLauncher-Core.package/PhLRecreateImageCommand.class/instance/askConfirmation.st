private
askConfirmation
	| confirmMessage |
	
	confirmMessage := 'Are you sure you want to recreate this image?' , Character cr asString, 
							'This will overwrite the existing image and you will lose changes.'.
	^ context newConfirmation
		message: (confirmMessage withNoLineLongerThan: 60) , '?';
		confirm.