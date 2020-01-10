Extension { #name : #PhLImageCreationPresenter }

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLImageCreationPresenter >> initScriptPresenter [
	^ initScript
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLImageCreationPresenter >> selectInitializationScript: anIndex [
	initScript selectIndex: anIndex
]
