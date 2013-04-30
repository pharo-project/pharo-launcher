as yet unclassified
open
	| defaultTab webTab otherTab existingTab associations tc personnalTab |
	
	defaultTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Default') selectCategory: 'Default'.
	webTab :=  PharoLauncherTabUI open: (PharoLauncherModel category: 'Web') selectCategory: 'Web'.
	otherTab := PharoLauncherTabUI open: (PharoLauncherModel category: 'Other') selectCategory: 'Other'.
	existingTab := PharoLauncherTabUI open: (PharoLauncherModelExistingImage category: 'Existing') selectCategory: 'Existing'.
	personnalTab := PharoLauncherTabUI open: (PharoLauncherModelLocalTemplate category: 'Personnal') selectCategory: 'Personnal'.
	
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab. 'Existing'-> existingTab. 'Personnal'-> personnalTab}.
	tc := self associations: associations. 
	tc open