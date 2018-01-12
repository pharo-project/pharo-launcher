accessing
persistence
	^ persistence ifNil: 
		[ persistence := SystemSettingsPersistence new 
			fileReference: PhLSettingBrowser preferencesFile;
			settingTree: self;
			yourself ]