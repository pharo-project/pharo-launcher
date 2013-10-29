initialization
initializeWidgets
	labelModel := self newLabel.
	(settingsButton := self newButton)
		icon: PhLOpenSettingsCommand icon;
		action: [ (PhLOpenSettingsCommand on: nil) execute ];
		state: false