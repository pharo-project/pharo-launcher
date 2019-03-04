Class {
	#name : #PLImageDescriptionPanelTest,
	#superclass : #PLAbstractSpecTestCase,
	#category : #'PharoLauncher-Spec-Tests'
}

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> createWithModel: anImage [

	instance := PLImageDescriptionPanel on: anImage.
	window := instance openWithSpec
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testArchitectureLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance architectureLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testArchitectureLabelLabel [

	self createWithModel: testImage.

	self assert: instance architectureLabelLabel label equals: 'Architecture:'
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testArchitectureLabelLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance architectureLabelLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testChangeImageUpdatesName [

	self createWithModel: PhLNullImage new.
	instance model: testImage.
	
	self assert: instance nameLabel label equals: testImage name asString.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testDescriptionLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance descriptionLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testDescriptionLabelLabel [

	self createWithModel: testImage.

	self assert: instance descriptionLabelLabel label equals: 'Description:'
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testDescriptionLabelLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance descriptionLabelLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testLocationLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance locationLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testLocationLabelLabel [

	self createWithModel: testImage.

	self assert: instance locationLabelLabel label equals: 'Location:'
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testLocationLabelLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance locationLabelLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testModifiedLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance modifiedLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testModifiedLabelLabel [

	self createWithModel: testImage.

	self assert: instance modifiedLabelLabel label equals: 'Modified:'
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testModifiedLabelLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance modifiedLabelLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testNameLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance nameLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testNameLabelLabel [

	self createWithModel: testImage.
	self assert: instance nameLabelLabel label equals: 'Name:'.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testNameLabelLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance nameLabelLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testTemplateLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance templateLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testTemplateLabelLabel [

	self createWithModel: testImage.
	
	self assert: instance templateLabelLabel label equals: 'Template:'.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testTemplateLabelLabelIsShown [

	self createWithModel: testImage.

	self assert: (window hasPresenter: instance templateLabelLabel)
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testWithImageShowsArchitecture [

	self createWithModel: testImage.
	
	self assert: instance architectureLabel label equals: testImage arch.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testWithImageShowsDescription [

	self createWithModel: testImage.
	
	self assert: instance descriptionLabel label equals: testImage description.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testWithImageShowsLocation [

	self createWithModel: testImage.
	
	self assert: instance locationLabel label equals: testImage location fullName
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testWithImageShowsModified [

	self createWithModel: testImage.
	
	self assert: instance modifiedLabel label equals: testImage modified asString.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testWithImageShowsName [

	self createWithModel: testImage.
	self assert: instance nameLabel label equals: testImage name.
]

{ #category : #'as yet unclassified' }
PLImageDescriptionPanelTest >> testWithImageShowsTemplate [

	self createWithModel: testImage.
	self assert: instance templateLabel label equals: testImage originTemplateName.
]
