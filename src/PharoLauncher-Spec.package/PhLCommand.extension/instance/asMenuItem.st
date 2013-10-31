*pharoLauncher-Spec
asMenuItem
	^ ToggleMenuItemMorph new
		contents: self title;
		target: self;
		selector: #execute;
		getStateSelector: nil;
		icon: self icon;
		enablementSelector: #isApplicable.