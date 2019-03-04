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

{ #category : #tests }
PhLNewPharoLauncherUITest >> testOpenDoesNotFail [

	| pharoLauncherRepository |
	pharoLauncherRepository := PhLMemoryImageRepository new.
	
	"Smoke test"
	(PhLNewPharoLauncherPresenter on: pharoLauncherRepository) openWithSpec close
]

{ #category : #tests }
PhLNewPharoLauncherUITest >> testRightClickOnImageHasLaunchMenu [

	| pharoLauncherRepository launcher menu |
	pharoLauncherRepository := PhLMemoryImageRepository new.
	pharoLauncherRepository addImage: PhLImage new.
	
	launcher := PhLNewPharoLauncherPresenter on: pharoLauncherRepository.
	menu := launcher imageTable rightClickAtIndex: 1.
	
	self assert: (menu items anySatisfy: [ :any | any halt ])
]
