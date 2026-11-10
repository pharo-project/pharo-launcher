"
I check the patch of SpMorphicLinkAdapter (see PhLSpecPatchLinkHelp).
"
Class {
	#name : 'PhLMorphicLinkHelpTest',
	#superclass : 'TestCase',
	#category : 'PharoLauncher-Tests-SpecUI',
	#package : 'PharoLauncher-Tests-SpecUI'
}

{ #category : 'tests' }
PhLMorphicLinkHelpTest >> testChangedHelpIsTheBalloonText [

	| link |
	link := SpLinkPresenter new
		        label: 'location';
		        yourself.
	link build.

	link help: '/an/image/location'.

	self assert: link adapter widget balloonText equals: '/an/image/location'
]

{ #category : 'tests' }
PhLMorphicLinkHelpTest >> testEmptyHelpHasNoBalloon [

	| link |
	link := SpLinkPresenter new
		        label: 'location';
		        help: '';
		        yourself.

	link build.

	self deny: link adapter widget wantsBalloon
]
