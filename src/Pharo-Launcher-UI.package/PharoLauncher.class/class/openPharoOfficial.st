opening
openPharoOfficial
	^ self new
			setTemplateGroup: PhLRemoteTemplateGroup pharoOfficialGroup imageGroup: PhLDirectoryBasedImageGroup inPharoPreferencesDirectory;
			open