"
I'm a simple presenter to fix the version of a Pharo image when no version file exists.
"
Class {
	#name : #PhLPharoVersionChooserPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TPhLInteractionTrait',
	#classTraits : 'TPhLInteractionTrait classTrait',
	#instVars : [
		'versionTable'
	],
	#category : #'PharoLauncher-Spec2'
}

{ #category : #examples }
PhLPharoVersionChooserPresenter class >> example [
	
	^ self new
		openDialog;
		yourself
]

{ #category : #layout }
PhLPharoVersionChooserPresenter >> defaultLayout [
	^ SpBoxLayout newHorizontal
		add: versionTable;
		yourself
]

{ #category : #initialization }
PhLPharoVersionChooserPresenter >> initializePresenters [
	versionTable := self newTable
		addColumn: ((SpStringTableColumn title: 'Pharo version' evaluated: #key) width: 100; yourself);
		addColumn: ((SpStringTableColumn 
			title: 'version string' 
			evaluated: #value) width: 60; yourself);
		showColumnHeaders;
		items: self pharoVersions;
		yourself
]

{ #category : #initialization }
PhLPharoVersionChooserPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Choose the Pharo version of the image:';
		initialExtent: 300@300;
		centered
]

{ #category : #accessing }
PhLPharoVersionChooserPresenter >> pharoVersions [
	| maxPharoVersion versions |
	maxPharoVersion := 12.
	versions := (#(1.2 1.3 1.4) copyWithAll: (2 to: maxPharoVersion)) reversed.

	^ versions collect: [ :v | 'Pharo ', v asString ->  (v * 10) asInteger asString]
]

{ #category : #versions }
PhLPharoVersionChooserPresenter >> version [
	^ versionTable selectedItem value
]
