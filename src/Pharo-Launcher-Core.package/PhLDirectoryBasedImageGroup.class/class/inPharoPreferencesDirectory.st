instance creation
inPharoPreferencesDirectory
	^ self new
		setBaseDirectory: FileLocator preferences / 'pharo' / 'images';
		yourself