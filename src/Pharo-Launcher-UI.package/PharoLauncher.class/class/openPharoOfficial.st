opening
openPharoOfficial
	^ self new
			setTemplateGroup: PhLRemoteLauncherTemplateGroup pharoOfficialGroup imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			open