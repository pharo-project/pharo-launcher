Extension { #name : 'PhLImageCreationPresenter' }

{ #category : '*PharoLauncher-Tests-SpecUI' }
PhLImageCreationPresenter >> imageName: aString [
	imageName text: aString
]

{ #category : '*PharoLauncher-Tests-SpecUI' }
PhLImageCreationPresenter >> initScriptPresenter [
	^ initializationScriptList
]

{ #category : '*PharoLauncher-Tests-SpecUI' }
PhLImageCreationPresenter >> selectInitializationScript: anIndex [
	initializationScriptList selectIndex: anIndex
]
