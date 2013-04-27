as yet unclassified
open: anURL
	| defaultTab webTab otherTab existingTab associations tc  |
	
	defaultTab :=  ImageLauncherTabUI open: (ImageLauncherModel category: 'Default') selectCategory: 'Default'.
	webTab :=  ImageLauncherTabUI open: (ImageLauncherModel category: 'Web') selectCategory: 'Web'.
	otherTab := ImageLauncherTabUI open: (ImageLauncherModel category: 'Other') selectCategory: 'Other'.
	existingTab := ImageLauncherTabUI open: (ImageLauncherModelExistingImage category: 'Existing') selectCategory: 'Existing'.
	
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab. 'Existing'-> existingTab}.
	tc := self associations: associations. 
	tc open