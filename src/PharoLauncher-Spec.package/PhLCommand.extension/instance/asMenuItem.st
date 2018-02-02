*pharoLauncher-Spec
asMenuItem
	^ MenuItemModel new
		name: self title;
		action: [ 
			self validateModelIntegrity ifTrue: [self execute ]];
		icon: self icon;
		enabled: self isApplicable.