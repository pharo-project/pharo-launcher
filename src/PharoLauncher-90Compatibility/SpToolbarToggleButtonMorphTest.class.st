Class {
	#name : #SpToolbarToggleButtonMorphTest,
	#superclass : #SpSmokeTest,
	#category : #'PharoLauncher-90Compatibility'
}

{ #category : #accessing }
SpToolbarToggleButtonMorphTest >> classToTest [

	^ SpToolbarToggleButtonPresenter 
]

{ #category : #tests }
SpToolbarToggleButtonMorphTest >> testClickDeactivatedCheckboxActivatesIt [
	| state |
	state := presenter isSelected.

	self openInstance.
	presenter adapter widget simulateClick.
		
	self assert: presenter isSelected equals: state not
]
