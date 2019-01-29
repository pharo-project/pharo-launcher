Class {
	#name : #PhLNewPharoLauncherUITest,
	#superclass : #TestCase,
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #tests }
PhLNewPharoLauncherUITest >> testImageListContainsImages [

	| pharoLauncherRepository presenter |
	pharoLauncherRepository := PhLMemoryImageRepository new.
	pharoLauncherRepository
		addImage: PhLImage new;
		addImage: PhLImage new.
	
	presenter := PhLNewPharoLauncherPresenter on: pharoLauncherRepository.
	
	self assert: presenter imageTable items size equals: 2.
]
