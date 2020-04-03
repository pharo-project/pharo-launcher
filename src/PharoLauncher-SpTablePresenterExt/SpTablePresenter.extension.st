Extension { #name : #SpTablePresenter }

{ #category : #'*PharoLauncher-SpTablePresenterExt' }
SpTablePresenter >> clickOnColumnHeaderAt: anIndex [
	self withAdapterDo: [ :tableAdapter | tableAdapter clickOnColumnHeaderAt: anIndex ]
]
