Class {
	#name : #PhLNewPharoLauncherPresenter,
	#superclass : #ComposablePresenterWithModel,
	#instVars : [
		'imageTable'
	],
	#category : #'PharoLauncher-Tests-SpecUI'
}

{ #category : #specs }
PhLNewPharoLauncherPresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :c |
			c add: #imageTable ];
		yourself
]

{ #category : #'instance creation' }
PhLNewPharoLauncherPresenter class >> open [

	^ (self on: PhLDirectoryBasedImageRepository default)
		openWithSpec
]

{ #category : #accessing }
PhLNewPharoLauncherPresenter >> imageTable [
	
	^ imageTable
]

{ #category : #initialization }
PhLNewPharoLauncherPresenter >> initializeWidgets [

	imageTable := self newTable.
	imageTable items: self model images.
]
