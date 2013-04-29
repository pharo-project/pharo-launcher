as yet unclassified
openWeb: anURL
	| defaultTab webTab otherTab existingTab associations tc  |
	
	defaultTab :=  ImageLauncherTabUI open: (ImageLauncherModel category: 'Default' url: anURL) selectCategory: 'Default'.
	webTab :=  ImageLauncherTabUI open: (ImageLauncherModel category: 'Web' url: anURL) selectCategory: 'Web'.
	otherTab := ImageLauncherTabUI open: (ImageLauncherModel category: 'Other' url: anURL) selectCategory: 'Other'.
	existingTab := ImageLauncherTabUI open: (ImageLauncherModelExistingImage category: 'Existing') selectCategory: 'Existing'.
	
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab. 'Existing'-> existingTab}.
	tc := self associations: associations. 
	tc open