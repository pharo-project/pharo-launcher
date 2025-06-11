Extension { #name : 'SpPresenter' }

{ #category : '*PharoLauncher-Spec2' }
SpPresenter >> newLaunchToolbar [

	^ self newToolbar
		addStyle: 'stToolbar';
		addStyle: 'compact';
		yourself
]
