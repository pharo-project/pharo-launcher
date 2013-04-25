as yet unclassified
open
	| defaultTab webTab otherTab associations tc model |
	
	model := ImageLauncherModel initialize.
	defaultTab :=  ImageLauncherTabUI open: model selectCategory: 'Default'.
	webTab :=  ImageLauncherTabUI open: model selectCategory: 'Web'.
	otherTab := ImageLauncherTabUI open: model selectCategory: 'Other'.
	
	associations := {'Default' -> defaultTab. 'Web'-> webTab. 'Other'-> otherTab}.
	tc := self associations: associations. 
	tc open