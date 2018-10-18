Extension { #name : #MorphTreeNodeMorph }

{ #category : #'*PharoLauncher-Spec' }
MorphTreeNodeMorph >> selected: aBoolean [
	self flag: 'TODO'.
	
	" This method is packaged in PharoLauncher because it contains a fix that has been included in Pharo 7.
	 see https://pharo.fogbugz.com/f/cases/20811/TreePresenter-selection-issue-when-tree-is-collapsed
	    and https://github.com/pharo-project/pharo-launcher/issues/104
	Once PharoLauncher starts to use Pharo 7, this method should be dropped."
	selected = aBoolean
		ifTrue: [^ self].
	container ifNil: [ ^ self ].
	aBoolean
		ifTrue: [container selectedMorphList add: self]
		ifFalse: [selected 
			ifNotNil: [container selectedMorphList remove: self]].
	selected := aBoolean.

	self complexContents selected: aBoolean
]
