Extension { #name : #SpToolBarPresenter }

{ #category : #'*PharoLauncher-Spec2' }
SpToolBarPresenter >> addItemLeft: aToolbarItem afterIndex: anIndex [
	
	aToolbarItem owner: self.
	leftItems add: aToolbarItem afterIndex: anIndex.
	self notifyPropertyChanged: #leftItems.
]
