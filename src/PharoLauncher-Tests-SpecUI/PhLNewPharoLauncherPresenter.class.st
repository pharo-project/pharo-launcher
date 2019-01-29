Class {
	#name : #PhLNewPharoLauncherPresenter,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'imageTable'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #accessing }
PhLNewPharoLauncherPresenter >> imageTable [
	
	^ imageTable
]

{ #category : #initialization }
PhLNewPharoLauncherPresenter >> initializeWidgets [

	imageTable := self newTable.
	imageTable items: self model images.
]
