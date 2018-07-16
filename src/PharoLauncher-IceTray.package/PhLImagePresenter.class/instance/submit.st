actions
submit

	workingModel name: self nameTextInput text.
	workingModel surname: self surnameTextInput text.
	
	self model: workingModel.
	self announcingObject valueChanged.
	