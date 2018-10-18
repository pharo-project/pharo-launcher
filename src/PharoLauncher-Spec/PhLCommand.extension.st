Extension { #name : #PhLCommand }

{ #category : #'*PharoLauncher-Spec' }
PhLCommand >> asMenuItem [
	^ MenuItemPresenter new
		name: self title;
		action: [ 
			self validateModelIntegrity ifTrue: [self execute ]];
		icon: self icon;
		enabled: self isApplicable.
]

{ #category : #'*pharoLauncher-Spec' }
PhLCommand class >> specId [
	^ (self title asCamelCase asLegalSelector, 'SpecId') asSymbol
]
