Extension { #name : 'SpTablePresenter' }

{ #category : '*PharoLauncher-Spec2' }
SpTablePresenter >> keepAlternateRowsColor [
	"Alternate rows color of every widget built for me.
	 #alternateRowsColor only configures the current widget, and the launcher rebuilds its widgets when switching theme."

	self whenBuiltDo: [ self alternateRowsColor ]
]
